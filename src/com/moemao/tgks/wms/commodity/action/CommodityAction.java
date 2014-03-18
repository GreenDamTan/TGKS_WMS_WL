package com.moemao.tgks.wms.commodity.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.moemao.tgks.common.core.action.TGKSAction;
import com.moemao.tgks.common.tool.CommonConstant;
import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.common.tool.StringUtil;
import com.moemao.tgks.wms.commodity.entity.CommodityEvt;
import com.moemao.tgks.wms.commodity.entity.CommodityReq;
import com.moemao.tgks.wms.commodity.service.CommodityService;
import com.moemao.tgks.wms.supplier.entity.SupplierEvt;
import com.moemao.tgks.wms.supplier.entity.SupplierReq;
import com.moemao.tgks.wms.supplier.service.SupplierService;

public class CommodityAction extends TGKSAction
{
	
	/**
     * 
     */
	private static final long serialVersionUID = -8778548388321157996L;
	
	private static Log logger = LogFactory.getLog(CommodityAction.class);
	
	/**
	 * ﻿Commodity业务接口
	 */
	private CommodityService wms_commodityService;
	
	/**
	 * ﻿Supplier业务接口
	 */
	private SupplierService wms_supplierService;
	
	/**
	 * 查询结果集
	 */
	private List<CommodityEvt> list;
	
	private List<SupplierEvt> supplierList;
	
	/**
	 * ﻿CommodityEvt对象
	 */
	private CommodityEvt commodityEvt;
	
	/**
	 * ﻿Commodity查询条件封装对象
	 */
	private CommodityReq commodityReq;
	
	public String commodityManager()
	{
		supplierList = wms_supplierService.querySupplier(new SupplierReq());
		return SUCCESS;
	}
	
	public String queryCommodity()
	{
		list = wms_commodityService.queryCommodity(commodityReq);
		return SUCCESS;
	}
	
	public String editCommodityPage()
	{
		String id = this.getRequest().getParameter("id");
		if (!CommonUtil.isEmpty(id))
		{
			commodityEvt = wms_commodityService.queryCommodityById(id);
		}
		
		// 查询供货商信息
		supplierList = wms_supplierService.querySupplier(new SupplierReq());
		
		return SUCCESS;
	}
	
	public String editCommodity()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "CommodityAction.updateCommodity");
		int result = 0;
		if (CommonUtil.isEmpty(commodityEvt.getId()))
		{
			result = wms_commodityService.addCommodity(commodityEvt);
		}
		else
		{
			result = wms_commodityService.updateCommodity(commodityEvt);
		}
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "CommodityAction.updateCommodity");
		return SUCCESS;
	}
	
	public String deleteCommodity()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "CommodityAction.deleteCommodity");
		String ids = this.getRequest().getParameter("ids");
		int result = wms_commodityService.deleteCommodity(CommonUtil
		        .stringToList(ids));
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "CommodityAction.deleteCommodity");
		return SUCCESS;
	}
	
	/**
	 * @return 返回 wms_commodityService
	 */
	public CommodityService getWms_commodityService()
	{
		return wms_commodityService;
	}
	
	/**
	 * @param 对wms_commodityService进行赋值
	 */
	public void setWms_commodityService(CommodityService wms_commodityService)
	{
		this.wms_commodityService = wms_commodityService;
	}
	
	/**
	 * @return 返回 list
	 */
	public List<CommodityEvt> getList()
	{
		return list;
	}
	
	/**
	 * @param 对list进行赋值
	 */
	public void setList(List<CommodityEvt> list)
	{
		this.list = list;
	}
	
	/**
	 * @return 返回 commodityEvt
	 */
	public CommodityEvt getCommodityEvt()
	{
		return commodityEvt;
	}
	
	/**
	 * @param 对commodityEvt进行赋值
	 */
	public void setCommodityEvt(CommodityEvt commodityEvt)
	{
		this.commodityEvt = commodityEvt;
	}
	
	/**
	 * @return 返回 commodityReq
	 */
	public CommodityReq getCommodityReq()
	{
		return commodityReq;
	}
	
	/**
	 * @param 对commodityReq进行赋值
	 */
	public void setCommodityReq(CommodityReq commodityReq)
	{
		this.commodityReq = commodityReq;
	}

	public SupplierService getWms_supplierService()
    {
    	return wms_supplierService;
    }

	public void setWms_supplierService(SupplierService wms_supplierService)
    {
    	this.wms_supplierService = wms_supplierService;
    }

	public List<SupplierEvt> getSupplierList()
    {
    	return supplierList;
    }

	public void setSupplierList(List<SupplierEvt> supplierList)
    {
    	this.supplierList = supplierList;
    }
}