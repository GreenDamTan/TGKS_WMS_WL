package com.moemao.tgks.wms.outboundorder.entity;

import java.util.Date;
import java.util.List;

import com.moemao.tgks.wms.outbound.entity.OutboundEvt;

public class OutboundOrderEvt
{
	/**
	 * 表唯一主键
	 */
	private String id;
	
	/**
	 * 出库记录ID
	 */
	private String outboundId;
	
	/**
	 * 客户
	 */
	private String custom;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	
	private List<OutboundEvt> list;
	
	/**
	 * @return 返回 id
	 */
	public String getId()
	{
		return id;
	}
	
	/**
	 * @param 对id进行赋值
	 */
	public void setId(String id)
	{
		this.id = id;
	}
	
	/**
	 * @return 返回 outboundId
	 */
	public String getOutboundId()
	{
		return outboundId;
	}
	
	/**
	 * @param 对outboundId进行赋值
	 */
	public void setOutboundId(String outboundId)
	{
		this.outboundId = outboundId;
	}
	
	/**
	 * @return 返回 custom
	 */
	public String getCustom()
	{
		return custom;
	}
	
	/**
	 * @param 对custom进行赋值
	 */
	public void setCustom(String custom)
	{
		this.custom = custom;
	}
	
	/**
	 * @return 返回 createTime
	 */
	public Date getCreateTime()
	{
		return createTime;
	}
	
	/**
	 * @param 对createTime进行赋值
	 */
	public void setCreateTime(Date createTime)
	{
		this.createTime = createTime;
	}

	public List<OutboundEvt> getList()
    {
    	return list;
    }

	public void setList(List<OutboundEvt> list)
    {
    	this.list = list;
    }
	
}