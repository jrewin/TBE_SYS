package com.tbe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tbe.beans.User;
import com.tbe.beans.UserExample;
import com.tbe.beans.UserExample.Criteria;
import com.tbe.dao.UserMapper;


@Service(value="userSerivce")
public class UserSerivceImpl implements UserService{
	
	@Autowired
	private UserMapper userMapper;
	
	@Transactional
	@Override
	public User getUser(User u) {
		
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andCoreidEqualTo(u.getCoreid());
		criteria.andPwEqualTo(u.getPw());
		criteria.andLvGreaterThanOrEqualTo(3);

		List<User> users = userMapper.selectByExample(example);
		
		return users.size() == 0?null:users.get(0);
	}
}
