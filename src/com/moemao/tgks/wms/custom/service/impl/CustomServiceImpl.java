package com.moemao.tgks.wms.custom.service.impl;

import java.util.List;

import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.wms.custom.dao.CustomDao;
import com.moemao.tgks.wms.custom.entity.CustomEvt;
import com.moemao.tgks.wms.custom.entity.CustomReq;
import com.moemao.tgks.wms.custom.service.CustomService;
import com.moemao.tgks.wms.tool.WmsUtil;

public class CustomServiceImpl implements CustomService
{
	/**
	 * ﻿CustomDao
	 */
	private CustomDao wms_customDao;
	
	public List<CustomEvt> queryCustom(CustomReq customReq)
	{
		if (CommonUtil.isEmpty(customReq.getSortSql()))
		{
			customReq.setSortSql(" t.ID DESC");
		}
		return wms_customDao.wms_queryCustom(customReq);
	}
	
	public CustomEvt queryCustomById(String id)
	{
		CustomReq customReq = new CustomReq();
		customReq.setId(id);
		CustomEvt customEvt = null;
		List<CustomEvt> customList = wms_customDao.wms_queryCustom(customReq);
		if (!CommonUtil.isEmpty(customList))
		{
			customEvt = customList.get(0);
		}
		return customEvt;
	}
	
	public int addCustom(CustomEvt customEvt)
	{
		customEvt.setId(WmsUtil.createUniqueID());
		return wms_customDao.wms_addCustom(customEvt);
	}
	
	public int updateCustom(CustomEvt customEvt)
	{
		return wms_customDao.wms_updateCustom(customEvt);
	}
	
	public int deleteCustom(List<String> ids)
	{
		return wms_customDao.wms_deleteCustom(ids);
	}
	
	/**
	 * @return 返回 wms_customDao
	 */
	public CustomDao getWms_customDao()
	{
		return wms_customDao;
	}
	
	/**
	 * @param 对wms_customDao进行赋值
	 */
	public void setWms_customDao(CustomDao wms_customDao)
	{
		this.wms_customDao = wms_customDao;
	}
	
}