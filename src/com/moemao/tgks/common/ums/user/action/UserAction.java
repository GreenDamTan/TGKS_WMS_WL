package com.moemao.tgks.common.ums.user.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.moemao.tgks.common.core.action.TGKSAction;
import com.moemao.tgks.common.tool.CommonConstant;
import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.common.tool.StringUtil;
import com.moemao.tgks.common.ums.user.entity.UserEvt;
import com.moemao.tgks.common.ums.user.entity.UserReq;
import com.moemao.tgks.common.ums.user.service.UserService;

public class UserAction extends TGKSAction
{
	
	/**
     * 
     */
    private static final long serialVersionUID = -2265283012657742492L;

	private static Log logger = LogFactory.getLog(UserAction.class);
	
	/**
	 * ﻿User业务接口
	 */
	private UserService ums_userService;
	
	/**
	 * 查询结果集
	 */
	private List<UserEvt> list;
	
	/**
	 * ﻿UserEvt对象
	 */
	private UserEvt userEvt;
	
	/**
	 * ﻿User查询条件封装对象
	 */
	private UserReq userReq = new UserReq();
	
	public String userManager()
	{
		return SUCCESS;
	}
	
	public String queryUser()
	{
		list = ums_userService.queryUser(userReq);
		return SUCCESS;
	}
	
	public String editUserPage()
	{
		String id = this.getRequest().getParameter("id");
		if (!CommonUtil.isEmpty(id))
		{
			userEvt = ums_userService.queryUserById(id);
		}
		return SUCCESS;
	}
	
	public String editUser()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "UserAction.updateUser");
		int result = 0;
		if (CommonUtil.isEmpty(userEvt.getId()))
		{
			result = ums_userService.addUser(userEvt);
		}
		else
		{
			result = ums_userService.updateUser(userEvt);
		}
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "UserAction.updateUser");
		return SUCCESS;
	}
	
	public String deleteUser()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "UserAction.deleteUser");
		String ids = this.getRequest().getParameter("ids");
		int result = ums_userService.deleteUser(CommonUtil.stringToList(ids));
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "UserAction.deleteUser");
		return SUCCESS;
	}
	
	/**
	 * @return 返回 ums_userService
	 */
	public UserService getUms_userService()
	{
		return ums_userService;
	}
	
	/**
	 * @param 对ums_userService进行赋值
	 */
	public void setUms_userService(UserService ums_userService)
	{
		this.ums_userService = ums_userService;
	}
	
	/**
	 * @return 返回 list
	 */
	public List<UserEvt> getList()
	{
		return list;
	}
	
	/**
	 * @param 对list进行赋值
	 */
	public void setList(List<UserEvt> list)
	{
		this.list = list;
	}
	
	/**
	 * @return 返回 userEvt
	 */
	public UserEvt getUserEvt()
	{
		return userEvt;
	}
	
	/**
	 * @param 对userEvt进行赋值
	 */
	public void setUserEvt(UserEvt userEvt)
	{
		this.userEvt = userEvt;
	}
	
	/**
	 * @return 返回 userReq
	 */
	public UserReq getUserReq()
	{
		return userReq;
	}
	
	/**
	 * @param 对userReq进行赋值
	 */
	public void setUserReq(UserReq userReq)
	{
		this.userReq = userReq;
	}
	
}