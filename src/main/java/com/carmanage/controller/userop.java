package com.carmanage.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.carmanage.dao.cmusr;
import com.carmanage.Mapper.*;

@RestController
@RequestMapping("/cmusr")
public class userop {
    private final cmusrMapper cmusrMapper;

    @Autowired
    public userop(cmusrMapper cmusrMapper) {
        this.cmusrMapper = cmusrMapper;
    }

    //查找记录
    @GetMapping("/search/{username}")
    public cmusr selectByPrimaryKey(@PathVariable  String username)
    {
    	return cmusrMapper.selectByPrimaryKey(username);
    }
    
    
    //查找记录
    @GetMapping("/find/{uid}")
    public cmusr selectByUid(@PathVariable  Integer uid)
    {
    	return cmusrMapper.selectByUid(uid);
    }
    
    
    @GetMapping("/weixiu")
    public List<cmusr> weixiuget()
    {
    	return cmusrMapper.selectByAuthority3();
    }
    
    //删除一个记录
    @GetMapping("/delete/{username}")
    public int deleteByPrimaryKey(@PathVariable  String username)
    {
    	return cmusrMapper.deleteByPrimaryKey(username);
    }
    
    //修改一个记录
    @PostMapping("/update")
    public int updateByPrimaryKey(@RequestBody  cmusr row) 
    {
    	return cmusrMapper.updateByPrimaryKey(row);
    }
    
    //返回全部记录
    @GetMapping("/all")
    public List<cmusr> selectAll(){
        return cmusrMapper.selectAll();
    }
    
    //登录功能实现
    @PostMapping("/login")
    public String login(@RequestBody cmusr row) {
        cmusr user = selectByPrimaryKey(row.getUsername());
        if (user == null) {
            return "用户名不存在！";
        }
        if (!user.getPassword().equals(row.getPassword())) {
            return "密码错误！";
        }
        return "登录成功！";
    }
    
    //注册功能实现
    @PostMapping("/register")
    public String register(@RequestBody  cmusr row) 
    {
    	cmusr user = selectByPrimaryKey(row.getUsername());
    	if (user != null) {
			return "用户名已存在！";
		}
    	
    	List<cmusr> all = cmusrMapper.selectAll();
		if(row.getAuthority() == null)
		{
			row.setAuthority(1);
		}
	        else
		{
			row.setAuthority(row.getAuthority());
		}

    	
    	int maxUid = all.stream().mapToInt(cmusr::getUid).max().orElse(0);
    	row.setUid(maxUid+1);
    	if (cmusrMapper.insert(row) == 1) {
			return "注册成功！";
		}
    	else {
			return"注册失败！";
		}
    }
    
}
