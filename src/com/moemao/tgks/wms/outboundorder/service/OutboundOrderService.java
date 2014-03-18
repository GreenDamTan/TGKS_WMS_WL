package com.moemao.tgks.wms.outboundorder.service;

import java.util.List;

import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderEvt;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderReq;

public interface OutboundOrderService
{
	public List<OutboundOrderEvt> queryOutboundOrder(OutboundOrderReq outboundOrderReq);
	
	public OutboundOrderEvt queryOutboundOrderById(String id);
	
	public List<OutboundOrderEvt> queryOutboundOrderByIds(List<String> ids);
	
	public OutboundOrderEvt addOutboundOrder(OutboundOrderEvt outboundOrderEvt);
	
	public int updateOutboundOrder(OutboundOrderEvt outboundOrderEvt);
	
	public int deleteOutboundOrder(List<String> ids);

}