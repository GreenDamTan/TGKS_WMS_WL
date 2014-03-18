package com.moemao.tgks.wms.outbound.service;

import java.util.List;

import com.moemao.tgks.wms.outbound.entity.OutboundEvt;
import com.moemao.tgks.wms.outbound.entity.OutboundReq;

public interface OutboundService
{
	public List<OutboundEvt> queryOutbound(OutboundReq outboundReq);
	
	public OutboundEvt queryOutboundById(String id);
	
	public List<OutboundEvt> queryOutboundByIds(List<String> ids);
	
	public int addOutbound(OutboundEvt outboundEvt);
	
	public int updateOutbound(OutboundEvt outboundEvt);
	
	public int deleteOutbound(List<String> ids);
	
	public int updateOutboundPrint(List<String> ids, String print);
	
}