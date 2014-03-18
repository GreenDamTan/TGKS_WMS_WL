package com.moemao.tgks.wms.storage.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.moemao.tgks.common.core.action.TGKSAction;
import com.moemao.tgks.common.tool.CommonConstant;
import com.moemao.tgks.common.tool.CommonUtil;
import com.moemao.tgks.common.tool.StringUtil;
import com.moemao.tgks.wms.commodity.entity.CommodityEvt;
import com.moemao.tgks.wms.commodity.service.CommodityService;
import com.moemao.tgks.wms.storage.entity.StorageEvt;
import com.moemao.tgks.wms.storage.entity.StorageReq;
import com.moemao.tgks.wms.storage.service.StorageService;
import com.moemao.tgks.wms.supplier.entity.SupplierEvt;
import com.moemao.tgks.wms.supplier.entity.SupplierReq;
import com.moemao.tgks.wms.supplier.service.SupplierService;
import com.moemao.tgks.wms.tool.WmsConstant;

public class StorageAction extends TGKSAction
{
	
	/**
     * 
     */
    private static final long serialVersionUID = -8993821302693769256L;

	private static Log logger = LogFactory.getLog(StorageAction.class);
	
	/**
	 * ﻿Storage业务接口
	 */
	private StorageService wms_storageService;
	
	private CommodityService wms_commodityService;
	
	/**
	 * ﻿Supplier业务接口
	 */
	private SupplierService wms_supplierService;
	
	/**
	 * 查询结果集
	 */
	private List<StorageEvt> list;
	
	private List<SupplierEvt> supplierList;
	
	/**
	 * ﻿StorageEvt对象
	 */
	private StorageEvt storageEvt;
	
	private CommodityEvt commodityEvt;
	
	/**
	 * ﻿Storage查询条件封装对象
	 */
	private StorageReq storageReq = new StorageReq();
	
	public String storageManager()
	{
		supplierList = wms_supplierService.querySupplier(new SupplierReq());
		return SUCCESS;
	}
	
	public String queryStorage()
	{
		list = wms_storageService.queryStorage(storageReq);
		return SUCCESS;
	}
	
	public String storagePage()
	{
		String id = this.getRequest().getParameter("id").trim();
		id = id.substring(0, id.length() - 1);
		commodityEvt = wms_commodityService.queryCommodityById(id);
		return SUCCESS;
	}
	
	/**
	 * 入库操作
	 * @return
	 */
	public String storage()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN, "StorageAction.storage");
		int result = 0;
		
		commodityEvt = wms_commodityService.queryCommodityById(storageEvt.getCommodityId());
		
		// 封装入库记录参数
		storageEvt.setCode(commodityEvt.getCode());
		storageEvt.setName(commodityEvt.getName());
		storageEvt.setType(commodityEvt.getType());
		
		// 入库记录暂时不需要打印，状态记0
		storageEvt.setPrint(WmsConstant.WMS_PRINT_STATUS_0);
		storageEvt.setUnit(commodityEvt.getUnit());
		storageEvt.setMaterial(commodityEvt.getMaterial());
		storageEvt.setModel(commodityEvt.getModel());
		storageEvt.setSpec(commodityEvt.getSpec());
		storageEvt.setSupplier(commodityEvt.getSupplier());
		
		// 新增入库记录
		result = wms_storageService.addStorage(storageEvt);
		
		// 入库记录日志
		CommonUtil.infoLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS, StringUtil.toBeString(result));
		
		// 增加库存数量
		commodityEvt.setNumber(commodityEvt.getNumber() + storageEvt.getNumber());
		
		// 修改最新价格
		commodityEvt.setPrice(storageEvt.getPrice());
		
		// 修改库存为已入库
		commodityEvt.setStatus(WmsConstant.WMS_COMMODITY_STATUS_1);
		
		// 修改库存信息
		result = wms_commodityService.updateCommodity(commodityEvt);
		
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT, "StorageAction.storage");
		
		return SUCCESS;
	}
	
	/**
	 * 取消入库操作
	 * @return
	 */
	public String cancelStorage()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN, "StorageAction.cancelStorage");
		String id = this.getRequest().getParameter("id").trim();
		
		int result = 0;
		
		// 查询出该条入库记录
		storageEvt = wms_storageService.queryStorageById(id);
		
		// 查询入库记录对应库存记录
		commodityEvt = wms_commodityService.queryCommodityById(storageEvt.getCommodityId());
		
		// 增加库存数量
		commodityEvt.setNumber(commodityEvt.getNumber() - storageEvt.getNumber());
		
		// 修改库存信息
		result = wms_commodityService.updateCommodity(commodityEvt);
		
		// 操作结果日志
		CommonUtil.infoLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS, StringUtil.toBeString(result));
		
		// 删除该条入库记录
		wms_storageService.deleteStorage(CommonUtil.stringToList(id));
		
		// 取消入库记录日志
		CommonUtil.infoLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS, StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT, "StorageAction.cancelStorage");
		return SUCCESS;
	}
	
	public String editStoragePage()
	{
		String id = this.getRequest().getParameter("id");
		if (!CommonUtil.isEmpty(id))
		{
			storageEvt = wms_storageService.queryStorageById(id);
		}
		return SUCCESS;
	}
	
	public String editStorage()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "StorageAction.updateStorage");
		int result = 0;
		if (CommonUtil.isEmpty(storageEvt.getId()))
		{
			result = wms_storageService.addStorage(storageEvt);
		}
		else
		{
			result = wms_storageService.updateStorage(storageEvt);
		}
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "StorageAction.updateStorage");
		return SUCCESS;
	}
	
	public String deleteStorage()
	{
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_IN,
		        "StorageAction.deleteStorage");
		String ids = this.getRequest().getParameter("ids");
		int result = wms_storageService.deleteStorage(CommonUtil
		        .stringToList(ids));
		CommonUtil.infoLog(logger,
		        CommonConstant.SYSTEM_INFO_LOG_METHOD_EXECUTE_NUMS,
		        StringUtil.toBeString(result));
		CommonUtil.debugLog(logger, CommonConstant.SYSTEM_INFO_LOG_METHOD_OUT,
		        "StorageAction.deleteStorage");
		return SUCCESS;
	}
	
	/**
	 * @return 返回 wms_storageService
	 */
	public StorageService getWms_storageService()
	{
		return wms_storageService;
	}
	
	/**
	 * @param 对wms_storageService进行赋值
	 */
	public void setWms_storageService(StorageService wms_storageService)
	{
		this.wms_storageService = wms_storageService;
	}
	
	/**
	 * @return 返回 list
	 */
	public List<StorageEvt> getList()
	{
		return list;
	}
	
	/**
	 * @param 对list进行赋值
	 */
	public void setList(List<StorageEvt> list)
	{
		this.list = list;
	}
	
	/**
	 * @return 返回 storageEvt
	 */
	public StorageEvt getStorageEvt()
	{
		return storageEvt;
	}
	
	/**
	 * @param 对storageEvt进行赋值
	 */
	public void setStorageEvt(StorageEvt storageEvt)
	{
		this.storageEvt = storageEvt;
	}
	
	/**
	 * @return 返回 storageReq
	 */
	public StorageReq getStorageReq()
	{
		return storageReq;
	}
	
	/**
	 * @param 对storageReq进行赋值
	 */
	public void setStorageReq(StorageReq storageReq)
	{
		this.storageReq = storageReq;
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

	public List<SupplierEvt> getSupplierList()
    {
    	return supplierList;
    }

	public void setSupplierList(List<SupplierEvt> supplierList)
    {
    	this.supplierList = supplierList;
    }

	public SupplierService getWms_supplierService()
    {
    	return wms_supplierService;
    }

	public void setWms_supplierService(SupplierService wms_supplierService)
    {
    	this.wms_supplierService = wms_supplierService;
    }
	
}