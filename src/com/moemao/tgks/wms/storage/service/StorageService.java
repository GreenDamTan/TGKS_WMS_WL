package com.moemao.tgks.wms.storage.service;

import java.util.List;

import com.moemao.tgks.wms.storage.entity.StorageEvt;
import com.moemao.tgks.wms.storage.entity.StorageReq;

public interface StorageService
{
	public List<StorageEvt> queryStorage(StorageReq storageReq);
	
	public StorageEvt queryStorageById(String id);
	
	public int addStorage(StorageEvt storageEvt);
	
	public int updateStorage(StorageEvt storageEvt);
	
	public int deleteStorage(List<String> ids);
	
}