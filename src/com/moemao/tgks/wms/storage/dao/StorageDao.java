package com.moemao.tgks.wms.storage.dao;

import java.util.List;
import org.springframework.dao.DataAccessException;
import com.moemao.tgks.common.core.dao.TGKSDao;
import com.moemao.tgks.wms.storage.entity.StorageEvt;
import com.moemao.tgks.wms.storage.entity.StorageReq;

public interface StorageDao extends TGKSDao
{
	public List<StorageEvt> wms_queryStorage(StorageReq storageReq)
	        throws DataAccessException;
	
	public int wms_addStorage(StorageEvt storageEvt) throws DataAccessException;
	
	public int wms_updateStorage(StorageEvt storageEvt)
	        throws DataAccessException;
	
	public int wms_deleteStorage(List<String> list) throws DataAccessException;
}