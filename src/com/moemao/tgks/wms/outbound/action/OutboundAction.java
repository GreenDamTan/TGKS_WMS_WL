package com.moemao.tgks.wms.outbound.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.moemao.tgks.common.core.action.TGKSAction;
import com.moemao.tgks.common.tool.CommonConstant;
import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.common.tool.StringUtil;
import com.moemao.tgks.wms.commodity.entity.CommodityEvt;
import com.moemao.tgks.wms.commodity.service.CommodityService;
import com.moemao.tgks.wms.custom.entity.CustomEvt;
import com.moemao.tgks.wms.custom.entity.CustomReq;
import com.moemao.tgks.wms.custom.service.CustomService;
import com.moemao.tgks.wms.outbound.entity.OutboundEvt;
import com.moemao.tgks.wms.outbound.entity.OutboundReq;
import com.moemao.tgks.wms.outbound.service.OutboundService;
import com.moemao.tgks.wms.outboundorder.entity.OutboundOrderEvt;
import com.moemao.tgks.wms.outboundorder.service.OutboundOrderService;
import com.moemao.tgks.wms.tool.WmsConstant;

public class OutboundAction extends TGKSAction
{
	
	/**
     * 
     */
    private static final long serialVersionUID = 3357214287461955890L;

	private static Log logger = LogFactory.getLog(OutboundAction.class);
	
	/**
	 * ﻿Outbound业务接口
	 */
	private OutboundService wms_outboundService;
	
	private CommodityService wms_commodityService;
	
	private CustomService wms_customService;
	
	private OutboundOrderService wms_outboundOrderService;
	
	/**
	 * 查询结果集
	 */
	private List<OutboundEvt> list;
	
	private List<CustomEvt> customList;
	
	/**
	 * ﻿OutboundEvt对象
	 */
	private OutboundEvt outboundEvt;
	
	private CommodityEvt commodityEvt;
	
	private OutboundOrderEvt outboundOrderEvt;
	
	/**
	 * ﻿Outbound查询条件封装对象
	 */
	private OutboundReq outboundReq = new OutboundReq();
	
	/**
	 * 出货单总价
	 */
	private double totalPrice;
	
	public String outboundManager()
	{
		customList = wms_customService.queryCustom(new CustomReq());
		return SUCCESS;
	}
	
	public String queryOutbound()
	{
		list = wms_outboundService.queryOutbound(outboundReq);
		return SUCCESS;
	}
	
	public String outboundPage()
	{
		String id = this.getRequest().getParameter("id").trim();
		id = id.substring(0, id.length() - 1);
		commodityEvt = wms_commodityService.queryCommodityById(id);
		
		// 查询客户信息
		customList = wms_customService.queryCustom(new CustomReq());
		
		return SUCCESS;
	}
	
	/**
	 * 出库操作
	 * @return
	 */
	public String outbound()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN, "OutboundAction.outbound");
		int result = 0;
		
		commodityEvt = wms_commodityService.queryCommodityById(outboundEvt.getCommodityId());
		
		// 封装入库记录参数
		outboundEvt.setCode(commodityEvt.getCode());
		outboundEvt.setName(commodityEvt.getName());
		outboundEvt.setType(commodityEvt.getType());
		outboundEvt.setPrint(WmsConstant.WMS_PRINT_STATUS_0);
		outboundEvt.setUnit(commodityEvt.getUnit());
		outboundEvt.setMaterial(commodityEvt.getMaterial());
		outboundEvt.setModel(commodityEvt.getModel());
		outboundEvt.setSpec(commodityEvt.getSpec());
		
		// 计算本次出库总金额
		double total = outboundEvt.getPrice()  * outboundEvt.getNumber() * (1 + outboundEvt.getTax());
		outboundEvt.setTotal(total);
		
		// 新增出库记录
		result = wms_outboundService.addOutbound(outboundEvt);
		
		// 出库记录日志
		CommonUtil.infoLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS, StringUtil.toBeString(result));
		
		// 减少库存数量
		commodityEvt.setNumber(commodityEvt.getNumber() - outboundEvt.getNumber());
		
		// 修改库存信息
		result = wms_commodityService.updateCommodity(commodityEvt);
		
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT, "OutboundAction.outbound");
		
		return SUCCESS;
	}
	
	/**
	 * 取消出库操作
	 * @return
	 */
	public String cancelOutbound()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN, "OutboundAction.cancelOutbound");
		
		String id = this.getRequest().getParameter("id").trim();
		
		int result = 0;
		
		outboundEvt = wms_outboundService.queryOutboundById(id);
		
		commodityEvt = wms_commodityService.queryCommodityById(outboundEvt.getCommodityId());
		
		// 增加库存数量
		commodityEvt.setNumber(commodityEvt.getNumber() + outboundEvt.getNumber());
		
		// 修改库存信息
		result = wms_commodityService.updateCommodity(commodityEvt);
		
		// 操作结果日志
		CommonUtil.infoLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS, StringUtil.toBeString(result));
		
		// 删除该条出库记录
		wms_outboundService.deleteOutbound(CommonUtil.stringToList(id));
		
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT, "OutboundAction.cancelOutbound");
		return SUCCESS;
	}
	
	public String editOutboundPage()
	{
		String id = this.getRequest().getParameter("id");
		if (!CommonUtil.isEmpty(id))
		{
			outboundEvt = wms_outboundService.queryOutboundById(id);
		}
		return SUCCESS;
	}
	
	public String editOutbound()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "OutboundAction.updateOutbound");
		int result = 0;
		if (CommonUtil.isEmpty(outboundEvt.getId()))
		{
			result = wms_outboundService.addOutbound(outboundEvt);
		}
		else
		{
			result = wms_outboundService.updateOutbound(outboundEvt);
		}
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "OutboundAction.updateOutbound");
		return SUCCESS;
	}
	
	public String deleteOutbound()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "OutboundAction.deleteOutbound");
		String ids = this.getRequest().getParameter("ids");
		int result = wms_outboundService.deleteOutbound(CommonUtil
		        .stringToList(ids));
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "OutboundAction.deleteOutbound");
		return SUCCESS;
	}
	
	/**
	 * 生成出货单	
	 * @return
	 */
	public String outboundOrder()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN, "OutboundAction.outboundOrder");
		String ids = this.getRequest().getParameter("ids");
		List<String> outboundIdList = new ArrayList<String>();
		
		// 查询出需要打印的出货记录
		list = wms_outboundService.queryOutboundByIds(CommonUtil.stringToList(ids));
		
		// 更新出货记录打印标志位
		wms_outboundService.updateOutboundPrint(CommonUtil.stringToList(ids), WmsConstant.WMS_PRINT_STATUS_1);
		
		for (OutboundEvt ob : list)
		{
			// totalPrice += ob.getTotal();
			
			outboundIdList.add(ob.getId());
		}
		
		// 数据库存储出货单数据
		outboundOrderEvt = new OutboundOrderEvt();
		outboundOrderEvt.setCustom(list.get(0).getCustom());
		outboundOrderEvt.setOutboundId(CommonUtil.listToString(outboundIdList));
		
		// 如果成功则返回刚才生成的记录
		outboundOrderEvt = wms_outboundOrderService.addOutboundOrder(outboundOrderEvt);
		
		CommonUtil.infoLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS, StringUtil.toBeString(list));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT, "OutboundAction.outboundOrder");
		return SUCCESS;
	}
	
	/**
	 * @return 返回 wms_outboundService
	 */
	public OutboundService getWms_outboundService()
	{
		return wms_outboundService;
	}
	
	/**
	 * @param 对wms_outboundService进行赋值
	 */
	public void setWms_outboundService(OutboundService wms_outboundService)
	{
		this.wms_outboundService = wms_outboundService;
	}
	
	/**
	 * @return
	 * @return 返回 list
	 */
	public List<OutboundEvt> getList()
	{
		return list;
	}
	
	/**
	 * @param 对list进行赋值
	 */
	public void setList(List<OutboundEvt> list)
	{
		this.list = list;
	}
	
	/**
	 * @return 返回 outboundEvt
	 */
	public OutboundEvt getOutboundEvt()
	{
		return outboundEvt;
	}
	
	/**
	 * @param 对outboundEvt进行赋值
	 */
	public void setOutboundEvt(OutboundEvt outboundEvt)
	{
		this.outboundEvt = outboundEvt;
	}

	public OutboundReq getOutboundReq()
    {
    	return outboundReq;
    }

	public void setOutboundReq(OutboundReq outboundReq)
    {
    	this.outboundReq = outboundReq;
    }

	public double getTotalPrice()
    {
    	return totalPrice;
    }

	public void setTotalPrice(double totalPrice)
    {
    	this.totalPrice = totalPrice;
    }

	public CommodityService getWms_commodityService()
    {
    	return wms_commodityService;
    }

	public void setWms_commodityService(CommodityService wms_commodityService)
    {
    	this.wms_commodityService = wms_commodityService;
    }

	public CommodityEvt getCommodityEvt()
    {
    	return commodityEvt;
    }

	public void setCommodityEvt(CommodityEvt commodityEvt)
    {
    	this.commodityEvt = commodityEvt;
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

	public OutboundOrderService getWms_outboundOrderService()
    {
    	return wms_outboundOrderService;
    }

	public void setWms_outboundOrderService(
            OutboundOrderService wms_outboundOrderService)
    {
    	this.wms_outboundOrderService = wms_outboundOrderService;
    }

	public OutboundOrderEvt getOutboundOrderEvt()
    {
    	return outboundOrderEvt;
    }

	public void setOutboundOrderEvt(OutboundOrderEvt outboundOrderEvt)
    {
    	this.outboundOrderEvt = outboundOrderEvt;
    }
}