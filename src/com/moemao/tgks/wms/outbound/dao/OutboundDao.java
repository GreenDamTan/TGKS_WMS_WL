package com.moemao.tgks.wms.outbound.dao;

import java.util.List;
import org.springframework.dao.DataAccessException;
import com.moemao.tgks.common.core.dao.TGKSDao;
import com.moemao.tgks.wms.outbound.entity.OutboundEvt;
import com.moemao.tgks.wms.outbound.entity.OutboundReq;

public interface OutboundDao extends TGKSDao
{
	public List<OutboundEvt> wms_queryOutbound(OutboundReq outboundReq)
	        throws DataAccessException;
	
	public List<OutboundEvt> wms_queryOutboundByIds(List<String> ids)
	        throws DataAccessException;
	
	public int wms_addOutbound(OutboundEvt outboundEvt)
	        throws DataAccessException;
	
	public int wms_updateOutbound(OutboundEvt outboundEvt)
	        throws DataAccessException;
	
	public int wms_deleteOutbound(List<String> list) throws DataAccessException;
	
	public int wms_updateOutboundPrintOn(List<String> list) throws DataAccessException;
}