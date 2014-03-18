package com.moemao.tgks.wms.outbound.service.impl;

import java.util.List;

import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.wms.outbound.dao.OutboundDao;
import com.moemao.tgks.wms.outbound.entity.OutboundEvt;
import com.moemao.tgks.wms.outbound.entity.OutboundReq;
import com.moemao.tgks.wms.outbound.service.OutboundService;
import com.moemao.tgks.wms.tool.WmsConstant;
import com.moemao.tgks.wms.tool.WmsUtil;

public class OutboundServiceImpl implements OutboundService
{
	/**
	 * ﻿OutboundDao
	 */
	private OutboundDao wms_outboundDao;
	
	public List<OutboundEvt> queryOutbound(OutboundReq outboundReq)
	{
		if (CommonUtil.isEmpty(outboundReq.getSortSql()))
		{
			outboundReq.setSortSql(" t.ID DESC");
		}
		return wms_outboundDao.wms_queryOutbound(outboundReq);
	}
	
	public OutboundEvt queryOutboundById(String id)
	{
		OutboundReq outboundReq = new OutboundReq();
		outboundReq.setId(id);
		OutboundEvt outboundEvt = null;
		List<OutboundEvt> outboundList = wms_outboundDao
		        .wms_queryOutbound(outboundReq);
		if (!CommonUtil.isEmpty(outboundList))
		{
			outboundEvt = outboundList.get(0);
		}
		return outboundEvt;
	}
	
	/**
	 * 更新打印状态
	 */
	public int updateOutboundPrint(List<String> ids, String print)
	{
		if (WmsConstant.WMS_PRINT_STATUS_0.equals(print))
		{
			
		}
		else if (WmsConstant.WMS_PRINT_STATUS_1.equals(print))
		{
			return wms_outboundDao.wms_updateOutboundPrintOn(ids);
		}
		
		return 0;
	}
	
	public List<OutboundEvt> queryOutboundByIds(List<String> ids)
	{
		return  wms_outboundDao.wms_queryOutboundByIds(ids);
	}
	
	public int addOutbound(OutboundEvt outboundEvt)
	{
		outboundEvt.setId(WmsUtil.createUniqueID());
		return wms_outboundDao.wms_addOutbound(outboundEvt);
	}
	
	public int updateOutbound(OutboundEvt outboundEvt)
	{
		return wms_outboundDao.wms_updateOutbound(outboundEvt);
	}
	
	public int deleteOutbound(List<String> ids)
	{
		return wms_outboundDao.wms_deleteOutbound(ids);
	}
	
	/**
	 * @return 返回 wms_outboundDao
	 */
	public OutboundDao getWms_outboundDao()
	{
		return wms_outboundDao;
	}
	
	/**
	 * @param 对wms_outboundDao进行赋值
	 */
	public void setWms_outboundDao(OutboundDao wms_outboundDao)
	{
		this.wms_outboundDao = wms_outboundDao;
	}
	
}