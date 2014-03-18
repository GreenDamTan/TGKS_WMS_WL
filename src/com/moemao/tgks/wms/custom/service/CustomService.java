package com.moemao.tgks.wms.custom.service;

import java.util.List;

import com.moemao.tgks.wms.custom.entity.CustomEvt;
import com.moemao.tgks.wms.custom.entity.CustomReq;

public interface CustomService
{
	public List<CustomEvt> queryCustom(CustomReq customReq);
	
	public CustomEvt queryCustomById(String id);
	
	public int addCustom(CustomEvt customEvt);
	
	public int updateCustom(CustomEvt customEvt);
	
	public int deleteCustom(List<String> ids);
	
}