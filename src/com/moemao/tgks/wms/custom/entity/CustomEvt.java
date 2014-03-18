package com.moemao.tgks.wms.custom.entity;

import java.util.Date;

public class CustomEvt
{
	/**
	 * 表唯一主键
	 */
	private String id;
	
	/**
	 * 客户名称
	 */
	private String name;
	
	/**
	 * 地址
	 */
	private String address;
	
	/**
	 * 电话
	 */
	private String tel;
	
	/**
	 * 传真
	 */
	private String fax;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	
	/**
	 * 备注
	 */
	private String remark;
	
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
	 * @return 返回 name
	 */
	public String getName()
	{
		return name;
	}
	
	/**
	 * @param 对name进行赋值
	 */
	public void setName(String name)
	{
		this.name = name;
	}
	
	/**
	 * @return 返回 address
	 */
	public String getAddress()
	{
		return address;
	}
	
	/**
	 * @param 对address进行赋值
	 */
	public void setAddress(String address)
	{
		this.address = address;
	}
	
	/**
	 * @return 返回 tel
	 */
	public String getTel()
	{
		return tel;
	}
	
	/**
	 * @param 对tel进行赋值
	 */
	public void setTel(String tel)
	{
		this.tel = tel;
	}
	
	/**
	 * @return 返回 fax
	 */
	public String getFax()
	{
		return fax;
	}
	
	/**
	 * @param 对fax进行赋值
	 */
	public void setFax(String fax)
	{
		this.fax = fax;
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
	
	/**
	 * @return 返回 remark
	 */
	public String getRemark()
	{
		return remark;
	}
	
	/**
	 * @param 对remark进行赋值
	 */
	public void setRemark(String remark)
	{
		this.remark = remark;
	}
	
}