package com.moemao.tgks.wms.custom.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.moemao.tgks.common.core.action.TGKSAction;
import com.moemao.tgks.common.tool.CommonConstant;
import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.common.tool.StringUtil;
import com.moemao.tgks.wms.custom.entity.CustomEvt;
import com.moemao.tgks.wms.custom.entity.CustomReq;
import com.moemao.tgks.wms.custom.service.CustomService;

public class CustomAction extends TGKSAction
{
	
	/**
     * 
     */
    private static final long serialVersionUID = 6595171862674266635L;

	private static Log logger = LogFactory.getLog(CustomAction.class);
	
	/**
	 * ﻿Custom业务接口
	 */
	private CustomService wms_customService;
	
	/**
	 * 查询结果集
	 */
	private List<CustomEvt> list;
	
	/**
	 * ﻿CustomEvt对象
	 */
	private CustomEvt customEvt;
	
	/**
	 * ﻿Custom查询条件封装对象
	 */
	private CustomReq customReq = new CustomReq();
	
	public String customManager()
	{
		return SUCCESS;
	}
	
	public String queryCustom()
	{
		list = wms_customService.queryCustom(customReq);
		return SUCCESS;
	}
	
	public String editCustomPage()
	{
		String id = this.getRequest().getParameter("id");
		if (!CommonUtil.isEmpty(id))
		{
			customEvt = wms_customService.queryCustomById(id);
		}
		return SUCCESS;
	}
	
	public String editCustom()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "CustomAction.updateCustom");
		int result = 0;
		if (CommonUtil.isEmpty(customEvt.getId()))
		{
			result = wms_customService.addCustom(customEvt);
		}
		else
		{
			result = wms_customService.updateCustom(customEvt);
		}
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "CustomAction.updateCustom");
		return SUCCESS;
	}
	
	public String deleteCustom()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "CustomAction.deleteCustom");
		String ids = this.getRequest().getParameter("ids");
		int result = wms_customService.deleteCustom(CommonUtil
		        .stringToList(ids));
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "CustomAction.deleteCustom");
		return SUCCESS;
	}
	
	/**
	 * @return 返回 wms_customService
	 */
	public CustomService getWms_customService()
	{
		return wms_customService;
	}
	
	/**
	 * @param 对wms_customService进行赋值
	 */
	public void setWms_customService(CustomService wms_customService)
	{
		this.wms_customService = wms_customService;
	}
	
	/**
	 * @return 返回 list
	 */
	public List<CustomEvt> getList()
	{
		return list;
	}
	
	/**
	 * @param 对list进行赋值
	 */
	public void setList(List<CustomEvt> list)
	{
		this.list = list;
	}
	
	/**
	 * @return 返回 customEvt
	 */
	public CustomEvt getCustomEvt()
	{
		return customEvt;
	}
	
	/**
	 * @param 对customEvt进行赋值
	 */
	public void setCustomEvt(CustomEvt customEvt)
	{
		this.customEvt = customEvt;
	}
	
	/**
	 * @return 返回 customReq
	 */
	public CustomReq getCustomReq()
	{
		return customReq;
	}
	
	/**
	 * @param 对customReq进行赋值
	 */
	public void setCustomReq(CustomReq customReq)
	{
		this.customReq = customReq;
	}
	
}