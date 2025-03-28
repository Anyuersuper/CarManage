package com.carmanage.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.carmanage.Mapper.cmorderMapper;
import com.carmanage.Mapper.cmsubMapper;
import com.carmanage.Mapper.cmusrMapper;
import com.carmanage.Mapper.cmworkorderMapper;
import com.carmanage.dao.cmorder;
import com.carmanage.dao.cmsub;
import com.carmanage.dao.cmusr;
import com.carmanage.dao.cmworkorder;

@RestController
@RequestMapping("/cmorder")
public class orderop {

	private final cmorderMapper cmorderMapper;
	private final cmusrMapper cmusrMapper;
	@Autowired
	public orderop(cmorderMapper cmorderMapper,cmusrMapper cmusrMapper) {
        this.cmorderMapper = cmorderMapper;
        this.cmusrMapper = cmusrMapper;
    }
	
	
	@GetMapping("/myorder")
    public List<cmorder> myorder(@CookieValue(value = "username", required = false) String username) {
    	if (cmusrMapper.selectByPrimaryKey(username).getAuthority() == 4) {
			return cmorderMapper.selectAll();
		}
    	else {
			return cmorderMapper.selectByUid(cmusrMapper.selectByPrimaryKey(username).getUid());
		}
    }
    
    
    //修改一个记录
    @PostMapping("/pay")
    public int updateByPrimaryKey(@RequestBody  cmorder row) 
    {
    	long currentTimeMillis = System.currentTimeMillis();
        Date currentDate = new Date(currentTimeMillis);
        row.setFinishedtime(currentDate);
        row.setStatus("已完成");
        return cmorderMapper.updateByPrimaryKey(row);
    }
    
    
    @GetMapping("/selectone")
    public List<cmorder> selectByCarid(@RequestParam String carid) {
        return cmorderMapper.selectByCarid(carid);
    }


    //查找一个记录根据selectByPrimaryKey
    @GetMapping("/find/{orderid}")
    public cmorder selectByPrimaryKey(@PathVariable String orderid) {
        return cmorderMapper.selectByPrimaryKey(orderid);
    }
	
}
