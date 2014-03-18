package com.moemao.tgks.wms.outboundorder.service.impl;

import java.util.List;

import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.wms.outboundorder.dao.OutboundOrderDao;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderEvt;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderReq;
import com.moemao.tgks.wms.outboundorder.service.OutboundOrderService;
import com.moemao.tgks.wms.tool.WmsUtil;

public class OutboundOrderServiceImpl implements OutboundOrderService
{
	/**
	 * ﻿OutboundOrderDao
	 */
	private OutboundOrderDao wms_outboundOrderDao;
	
	public List<OutboundOrderEvt> queryOutboundOrder(
	        OutboundOrderReq outboundOrderReq)
	{
		if (CommonUtil.isEmpty(outboundOrderReq.getSortSql()))
		{
			outboundOrderReq.setSortSql(" t.ID DESC");
		}
		return wms_outboundOrderDao.wms_queryOutboundOrder(outboundOrderReq);
	}
	
	public OutboundOrderEvt queryOutboundOrderById(String id)
	{
		OutboundOrderReq outboundOrderReq = new OutboundOrderReq();
		outboundOrderReq.setId(id);
		OutboundOrderEvt outboundOrderEvt = null;
		List<OutboundOrderEvt> outboundOrderList = wms_outboundOrderDao.wms_queryOutboundOrder(outboundOrderReq);
		if (!CommonUtil.isEmpty(outboundOrderList))
		{
			outboundOrderEvt = outboundOrderList.get(0);
		}
		return outboundOrderEvt;
	}
	
	public List<OutboundOrderEvt> queryOutboundOrderByIds(List<String> ids)
	{
		return wms_outboundOrderDao.wms_queryOutboundOrderByIds(ids);
	}
	
	public OutboundOrderEvt addOutboundOrder(OutboundOrderEvt outboundOrderEvt)
	{
		OutboundOrderReq outboundOrderReq = new OutboundOrderReq();
		
		outboundOrderEvt.setId(WmsUtil.createUniqueID());
		wms_outboundOrderDao.wms_addOutboundOrder(outboundOrderEvt);
		
		outboundOrderReq.setId(outboundOrderEvt.getId());
		
		List<OutboundOrderEvt> list = wms_outboundOrderDao.wms_queryOutboundOrder(outboundOrderReq);
		
		if (CommonUtil.isEmpty(list))
		{
			return null;
		}
		
		return list.get(0);
	}
	
	public int updateOutboundOrder(OutboundOrderEvt outboundOrderEvt)
	{
		return wms_outboundOrderDao.wms_updateOutboundOrder(outboundOrderEvt);
	}
	
	public int deleteOutboundOrder(List<String> ids)
	{
		return wms_outboundOrderDao.wms_deleteOutboundOrder(ids);
	}
	
	/**
	 * @return 返回 wms_outboundOrderDao
	 */
	public OutboundOrderDao getWms_outboundOrderDao()
	{
		return wms_outboundOrderDao;
	}
	
	/**
	 * @param 对wms_outboundOrderDao进行赋值
	 */
	public void setWms_outboundOrderDao(OutboundOrderDao wms_outboundOrderDao)
	{
		this.wms_outboundOrderDao = wms_outboundOrderDao;
	}
	
}