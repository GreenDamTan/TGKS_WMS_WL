package com.moemao.tgks.wms.storage.service.impl;

import java.util.List;

import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.wms.storage.dao.StorageDao;
import com.moemao.tgks.wms.storage.entity.StorageEvt;
import com.moemao.tgks.wms.storage.entity.StorageReq;
import com.moemao.tgks.wms.storage.service.StorageService;
import com.moemao.tgks.wms.tool.WmsUtil;

public class StorageServiceImpl implements StorageService
{
	/**
	 * ﻿StorageDao
	 */
	private StorageDao wms_storageDao;
	
	public List<StorageEvt> queryStorage(StorageReq storageReq)
	{
		if (CommonUtil.isEmpty(storageReq.getSortSql()))
		{
			storageReq.setSortSql(" t.ID DESC");
		}
		return wms_storageDao.wms_queryStorage(storageReq);
	}
	
	public StorageEvt queryStorageById(String id)
	{
		StorageReq storageReq = new StorageReq();
		storageReq.setId(id);
		StorageEvt storageEvt = null;
		List<StorageEvt> storageList = wms_storageDao
		        .wms_queryStorage(storageReq);
		if (!CommonUtil.isEmpty(storageList))
		{
			storageEvt = storageList.get(0);
		}
		return storageEvt;
	}
	
	public int addStorage(StorageEvt storageEvt)
	{
		storageEvt.setId(WmsUtil.createUniqueID());
		return wms_storageDao.wms_addStorage(storageEvt);
	}
	
	public int updateStorage(StorageEvt storageEvt)
	{
		return wms_storageDao.wms_updateStorage(storageEvt);
	}
	
	public int deleteStorage(List<String> ids)
	{
		return wms_storageDao.wms_deleteStorage(ids);
	}
	
	/**
	 * @return 返回 wms_storageDao
	 */
	public StorageDao getWms_storageDao()
	{
		return wms_storageDao;
	}
	
	/**
	 * @param 对wms_storageDao进行赋值
	 */
	public void setWms_storageDao(StorageDao wms_storageDao)
	{
		this.wms_storageDao = wms_storageDao;
	}
	
}