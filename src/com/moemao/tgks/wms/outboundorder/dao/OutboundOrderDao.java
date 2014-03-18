package com.moemao.tgks.wms.outboundorder.dao;

import java.util.List;
import org.springframework.dao.DataAccessException;
import com.moemao.tgks.common.core.dao.TGKSDao;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderEvt;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderReq;

public interface OutboundOrderDao extends TGKSDao
{
	public List<OutboundOrderEvt> wms_queryOutboundOrder(OutboundOrderReq outboundOrderReq) throws DataAccessException;
	
	public List<OutboundOrderEvt> wms_queryOutboundOrderByIds(List<String> list) throws DataAccessException;
	
	public int wms_addOutboundOrder(OutboundOrderEvt outboundOrderEvt) throws DataAccessException;
	
	public int wms_updateOutboundOrder(OutboundOrderEvt outboundOrderEvt) throws DataAccessException;
	
	public int wms_deleteOutboundOrder(List<String> list) throws DataAccessException;
}