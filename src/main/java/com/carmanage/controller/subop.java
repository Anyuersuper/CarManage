package com.carmanage.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.attribute.FileTime;
import java.rmi.server.UID;
import java.sql.Date;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.carmanage.Mapper.cmpicMapper;
import com.carmanage.Mapper.cmsubMapper;
import com.carmanage.Mapper.cmusrMapper;
import com.carmanage.Mapper.cmworkorderMapper;
import com.carmanage.dao.cmcar;
import com.carmanage.dao.cmpic;
import com.carmanage.dao.cmsub;
import com.carmanage.dao.cmusr;
import com.carmanage.dao.cmworkorder;

@RestController
@RequestMapping("/cmsub")

public class subop {
	private final cmsubMapper cmsubMapper;
	private final cmusrMapper cmusrMapper;
	private final cmworkorderMapper cmworkorderMapper;
	private final cmpicMapper cmpicMapper;
	private final String imagesavepath;

   
    @Autowired
    public subop(cmsubMapper cmsubMapper,cmusrMapper cmusrMapper,cmworkorderMapper cmworkorderMapper,cmpicMapper cmpicMapper,@Value("${image.savepath}") String imagesavepath) {
        this.cmsubMapper = cmsubMapper;
        this.cmusrMapper = cmusrMapper;
        this.cmworkorderMapper = cmworkorderMapper;
        this.cmpicMapper = cmpicMapper;
        this.imagesavepath = imagesavepath;
    }
    
    
    
   
    
    //查找记录根据uid
    @GetMapping("/find/{subid}")
    public cmsub selectByPrimaryKey(@PathVariable  String subid)
    {
    	return cmsubMapper.selectByPrimaryKey(subid);
    }
    
    //上传图片
    public int uploadImage(String subid, MultipartFile file) 
    {
	    if (file.isEmpty()) {
	        return 0;
	    }
	
	    // 计算 picid
	    List<cmpic> all = cmpicMapper.selectAll();
	    Instant now = Instant.now();
		long timestamp = now.toEpochMilli();
	    String picid = "img" + timestamp ;
	    
	    // 定义文件保存路径
	    String uploadDir = imagesavepath;
	    File dir = new File(uploadDir);
	    if (!dir.exists() && !dir.mkdirs()) {
	        return 0;
	    }
	
	    // 获取文件名并保存
	    String originalFilename = file.getOriginalFilename();
	    String filepath = uploadDir + picid + "_" + originalFilename;
	    File dest = new File(filepath);
	    try {
	        file.transferTo(dest);
	    } catch (IOException e) {
	        return 0;
	    }
	
	    // 插入 `cmpic` 记录
	    cmpic newPic = new cmpic();
	    newPic.setPicid(picid);
	    newPic.setSubid(subid);
	    newPic.setFilepath(filepath);
	    
	   
	

	    return cmpicMapper.insert(newPic);
    }

    
    
    @GetMapping("/mysub")
    public List<cmsub> mycar(@CookieValue(value = "username", required = false) String username) 
    {
        if (username == null) {
            return new ArrayList<>(); // 避免空指针异常
        }

        cmusr usr = cmusrMapper.selectByPrimaryKey(username);
        if (usr == null) {
            return new ArrayList<>();
        }

        int uid = usr.getUid();
        if (usr.getAuthority() == 4 || usr.getAuthority() == 2) {
            return cmsubMapper.selectAll();
        } else { 
            return cmsubMapper.selectByUid(uid);
        }
    }
    
    
    //修改一个记录
    @PostMapping("/update")
    public int updateByPrimaryKey(@RequestBody  cmsub row,@RequestParam int cmuid) 
    {
    	cmsub demo = cmsubMapper.selectByPrimaryKey(row.getSubid());
    	if (demo.getStatus().equals("已通过")) {
    		return cmsubMapper.updateByPrimaryKeySelective(row);
		}else {
    		if (row.getStatus().equals("已通过")) {
    			cmworkorder cmworkorderrow = new cmworkorder();
    			Instant now = Instant.now();
    			long timestamp = now.toEpochMilli();
    			cmworkorderrow.setWorkorderid( "GD"  +  timestamp );
    			cmworkorderrow.setUid(demo.getUid());
                cmworkorderrow.setCarid(demo.getCarid());
    			cmworkorderrow.setCmuid(cmuid);
    			long currentTimeMillis = System.currentTimeMillis();
    	        Date currentDate = new Date(currentTimeMillis);
    			cmworkorderrow.setStarttime(currentDate);
    			cmworkorderrow.setStatus("处理中");
    			if (cmworkorderMapper.insert(cmworkorderrow) == 1) {
    				return cmsubMapper.updateByPrimaryKeySelective(row);
				}
    			else {
					return 0;
				}
    		}
    		else {
    			return cmsubMapper.updateByPrimaryKeySelective(row);
			}
		}	
    }
    
   //增加一个记录
    @PostMapping("/add")
    public int insert(@RequestParam("content") String content,@RequestParam(value = "files", required = false) MultipartFile[] files,@CookieValue(value = "username", required = false) String username,@RequestParam ("carid") String carid) {

        if (username == null) {
            return 0; // 用户未登录，直接返回失败
        }

        // 计算 subid
        List<cmsub> all = cmsubMapper.selectAll();
        int uid = cmusrMapper.selectByPrimaryKey(username).getUid();
        Instant now = Instant.now();
		long timestamp = now.toEpochMilli();
        String subid = "SQ" + timestamp;

        System.out.print( subid);
        
        // 创建并插入 `cmsub`
        cmsub row = new cmsub();
        row.setSubid(subid);
        row.setUid(uid);
        row.setCarid(carid);
        row.setContent(content);
        row.setStatus("审批中");

        if (cmsubMapper.insert(row) != 1) {
            return 0; // 申请记录插入失败
        }

        // 处理文件上传（如果有）
        if (files != null && files.length > 0) {
            for (MultipartFile file : files) {
                int uploadResult = uploadImage(subid, file);
                if (uploadResult != 1) {
                    // 图片上传失败，删除申请记录
                    cmsubMapper.deleteByPrimaryKey(subid);
                    return 0;
                }
            }
        }

        return 1; // 申请成功 & 图片全部上传成功
    }


    @GetMapping("/selectone")
    public List<cmsub> selectByCarid(@RequestParam String carid)
    {
    	return cmsubMapper.selectByCarid(carid);
    }

    
    //删除一个记录
    @GetMapping("/delete/{subid}")
    public int deleteByPrimaryKey(@PathVariable  String subid)
    {
    	return cmsubMapper.deleteByPrimaryKey(subid);
    }
    
}
