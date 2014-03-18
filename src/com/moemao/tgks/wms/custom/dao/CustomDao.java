package com.moemao.tgks.wms.custom.dao;

import java.util.List;
import org.springframework.dao.DataAccessException;
import com.moemao.tgks.common.core.dao.TGKSDao;
import com.moemao.tgks.wms.custom.entity.CustomEvt;
import com.moemao.tgks.wms.custom.entity.CustomReq;

public interface CustomDao extends TGKSDao
{
	public List<CustomEvt> wms_queryCustom(CustomReq customReq)
	        throws DataAccessException;
	
	public int wms_addCustom(CustomEvt customEvt) throws DataAccessException;
	
	public int wms_updateCustom(CustomEvt customEvt) throws DataAccessException;
	
	public int wms_deleteCustom(List<String> list) throws DataAccessException;
}