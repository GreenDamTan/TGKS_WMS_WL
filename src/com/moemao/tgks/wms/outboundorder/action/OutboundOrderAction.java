package com.moemao.tgks.wms.outboundorder.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.moemao.tgks.common.core.action.TGKSAction;
import com.moemao.tgks.common.tool.CommonConstant;
import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.common.tool.StringUtil;
import com.moemao.tgks.wms.custom.entity.CustomEvt;
import com.moemao.tgks.wms.custom.entity.CustomReq;
import com.moemao.tgks.wms.custom.service.CustomService;
import com.moemao.tgks.wms.outbound.entity.OutboundEvt;
import com.moemao.tgks.wms.outbound.service.OutboundService;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderEvt;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderReq;
import com.moemao.tgks.wms.outboundorder.service.OutboundOrderService;

public class OutboundOrderAction extends TGKSAction
{
	
	/**
     * 
     */
    private static final long serialVersionUID = -2442612641298002772L;

	private static Log logger = LogFactory.getLog(OutboundOrderAction.class);
	
	/**
	 * ﻿OutboundOrder业务接口
	 */
	private OutboundOrderService wms_outboundOrderService;
	
	private OutboundService wms_outboundService;
	
	private CustomService wms_customService;
	
	/**
	 * 查询结果集
	 */
	private List<OutboundOrderEvt> outboundOrderList;
	
	private List<OutboundEvt> list;
	
	private List<CustomEvt> customList;
	
	/**
	 * ﻿OutboundOrderEvt对象
	 */
	private OutboundOrderEvt outboundOrderEvt;
	
	/**
	 * ﻿OutboundOrder查询条件封装对象
	 */
	private OutboundOrderReq outboundOrderReq = new OutboundOrderReq();
	
	private double totalPrice;
	
	private String printDate;
	
	public String outboundOrderManager()
	{
		customList = wms_customService.queryCustom(new CustomReq());
		return SUCCESS;
	}
	
	/**
	 * 查看送货单
	 * @return
	 */
	public String outboundOrderOrder()
	{
		String id = this.getRequest().getParameter("id");
		outboundOrderEvt = wms_outboundOrderService.queryOutboundOrderById(id);
		
		if (CommonUtil.isEmpty(outboundOrderEvt))
		{
			return ERROR;
		}
		
		list = wms_outboundService.queryOutboundByIds(CommonUtil.stringToList(outboundOrderEvt.getOutboundId()));
		
		return SUCCESS;
	}
	
	/**
	 * 生成对账单
	 * @return
	 */
	public String checkOutboundOrder()
	{
		String ids = this.getRequest().getParameter("ids");
		List<OutboundEvt> outboundList = new ArrayList<OutboundEvt>();
		
		outboundOrderList = wms_outboundOrderService.queryOutboundOrderByIds(CommonUtil.stringToList(ids));
		
		if (!CommonUtil.isEmpty(outboundOrderList))
		{
			outboundOrderEvt = outboundOrderList.get(0);
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		printDate = sdf.format(new Date());
		
		for (OutboundOrderEvt outboundOrder : outboundOrderList)
		{
			outboundList = wms_outboundService.queryOutboundByIds(CommonUtil.stringToList(outboundOrder.getOutboundId()));
			
			if (!CommonUtil.isEmpty(outboundList))
			{
				for (OutboundEvt obe : outboundList)
				{
					totalPrice += obe.getTotal();
				}
			}
			
			outboundOrder.setList(outboundList);
		}
		
		return SUCCESS;
	}
	
	public String queryOutboundOrder()
	{
		outboundOrderList = wms_outboundOrderService.queryOutboundOrder(outboundOrderReq);
		return SUCCESS;
	}
	
	public String editOutboundOrderPage()
	{
		String id = this.getRequest().getParameter("id");
		if (!CommonUtil.isEmpty(id))
		{
			outboundOrderEvt = wms_outboundOrderService
			        .queryOutboundOrderById(id);
		}
		return SUCCESS;
	}
	
	public String editOutboundOrder()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "OutboundOrderAction.updateOutboundOrder");
		int result = 1;
		if (CommonUtil.isEmpty(outboundOrderEvt.getId()))
		{
			wms_outboundOrderService.addOutboundOrder(outboundOrderEvt);
		}
		else
		{
			wms_outboundOrderService.updateOutboundOrder(outboundOrderEvt);
		}
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "OutboundOrderAction.updateOutboundOrder");
		return SUCCESS;
	}
	
	public String deleteOutboundOrder()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "OutboundOrderAction.deleteOutboundOrder");
		String ids = this.getRequest().getParameter("ids");
		int result = wms_outboundOrderService.deleteOutboundOrder(CommonUtil
		        .stringToList(ids));
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "OutboundOrderAction.deleteOutboundOrder");
		return SUCCESS;
	}
	
	/**
	 * @return 返回 wms_outboundOrderService
	 */
	public OutboundOrderService getWms_outboundOrderService()
	{
		return wms_outboundOrderService;
	}
	
	/**
	 * @param 对wms_outboundOrderService进行赋值
	 */
	public void setWms_outboundOrderService(
	        OutboundOrderService wms_outboundOrderService)
	{
		this.wms_outboundOrderService = wms_outboundOrderService;
	}
	
	/**
	 * @return 返回 outboundOrderEvt
	 */
	public OutboundOrderEvt getOutboundOrderEvt()
	{
		return outboundOrderEvt;
	}
	
	/**
	 * @param 对outboundOrderEvt进行赋值
	 */
	public void setOutboundOrderEvt(OutboundOrderEvt outboundOrderEvt)
	{
		this.outboundOrderEvt = outboundOrderEvt;
	}
	
	/**
	 * @return 返回 outboundOrderReq
	 */
	public OutboundOrderReq getOutboundOrderReq()
	{
		return outboundOrderReq;
	}
	
	/**
	 * @param 对outboundOrderReq进行赋值
	 */
	public void setOutboundOrderReq(OutboundOrderReq outboundOrderReq)
	{
		this.outboundOrderReq = outboundOrderReq;
	}

	public CustomService getWms_customService()
    {
    	return wms_customService;
    }

	public void setWms_customService(CustomService wms_customService)
    {
    	this.wms_customService = wms_customService;
    }

	public List<CustomEvt> getCustomList()
    {
    	return customList;
    }

	public void setCustomList(List<CustomEvt> customList)
    {
    	this.customList = customList;
    }

	public List<OutboundOrderEvt> getOutboundOrderList()
    {
    	return outboundOrderList;
    }

	public void setOutboundOrderList(List<OutboundOrderEvt> outboundOrderList)
    {
    	this.outboundOrderList = outboundOrderList;
    }

	public List<OutboundEvt> getList()
    {
    	return list;
    }

	public void setList(List<OutboundEvt> list)
    {
    	this.list = list;
    }

	public OutboundService getWms_outboundService()
    {
    	return wms_outboundService;
    }

	public void setWms_outboundService(OutboundService wms_outboundService)
    {
    	this.wms_outboundService = wms_outboundService;
    }

	public double getTotalPrice()
    {
    	return totalPrice;
    }

	public void setTotalPrice(double totalPrice)
    {
    	this.totalPrice = totalPrice;
    }

	public String getPrintDate()
    {
    	return printDate;
    }

	public void setPrintDate(String printDate)
    {
    	this.printDate = printDate;
    }

}