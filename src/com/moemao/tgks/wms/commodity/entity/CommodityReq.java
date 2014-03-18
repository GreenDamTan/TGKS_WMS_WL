package com.moemao.tgks.wms.commodity.entity;

import java.util.Date;

public class CommodityReq extends CommodityEvt
{
	/**
	 * 排序字段
	 */
	private String sortSql;
	
	private Date createTimeStart;
	
	private Date createTimeEnd;
	
	public Date getCreateTimeStart()
    {
    	return createTimeStart;
    }

	public void setCreateTimeStart(Date createTimeStart)
    {
    	this.createTimeStart = createTimeStart;
    }

	public Date getCreateTimeEnd()
    {
    	return createTimeEnd;
    }

	public void setCreateTimeEnd(Date createTimeEnd)
    {
    	this.createTimeEnd = createTimeEnd;
    }

	/**
	 * @return 返回 排序字段
	 */
	public String getSortSql()
	{
		return this.sortSql;
	}
	
	/**
	 * @param 对排序字段进行赋值
	 */
	public void setSortSql(String sortSql)
	{
		this.sortSql = sortSql;
	}
	
}