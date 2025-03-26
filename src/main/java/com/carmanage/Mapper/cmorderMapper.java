package com.carmanage.Mapper;

import java.util.List;

import com.carmanage.dao.cmorder;

public interface cmorderMapper {
    int deleteByPrimaryKey(String orderid);

    int insert(cmorder row);

    int insertSelective(cmorder row);

    cmorder selectByPrimaryKey(String orderid);

    int updateByPrimaryKeySelective(cmorder row);

    int updateByPrimaryKey(cmorder row);
    
    List<cmorder> selectAll();
    
    List<cmorder> selectByUid(Integer uid);
}