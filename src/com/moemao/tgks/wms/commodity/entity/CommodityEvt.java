package com.moemao.tgks.wms.commodity.entity;

import java.util.Date;

public class CommodityEvt
{
	/**
	 * 表唯一主键
	 */
	private String id;
	
	/**
	 * 库存编号
	 */
	private String code;
	
	/**
	 * 库存名称
	 */
	private String name;
	
	/**
	 * 库存分类（0 原材料；1 半成品；2 成品）
	 */
	private String type;
	
	/**
	 * 状态（0 草稿；1 正式入库）
	 */
	private String status;
	
	/**
	 * 库存数量
	 */
	private double number;
	
	/**
	 * 库存单位
	 */
	private String unit;
	
	/**
	 * 库存单价
	 */
	private double price;
	
	/**
	 * 材质
	 */
	private String material;
	
	/**
	 * 型号
	 */
	private String model;
	
	/**
	 * 规格
	 */
	private String spec;
	
	/**
	 * 供货商
	 */
	private String supplier;
	
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
	 * @return 返回 code
	 */
	public String getCode()
	{
		return code;
	}
	
	/**
	 * @param 对code进行赋值
	 */
	public void setCode(String code)
	{
		this.code = code;
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
	 * @return 返回 type
	 */
	public String getType()
	{
		return type;
	}
	
	/**
	 * @param 对type进行赋值
	 */
	public void setType(String type)
	{
		this.type = type;
	}
	
	/**
	 * @return 返回 status
	 */
	public String getStatus()
	{
		return status;
	}
	
	/**
	 * @param 对status进行赋值
	 */
	public void setStatus(String status)
	{
		this.status = status;
	}
	
	/**
	 * @return 返回 number
	 */
	public double getNumber()
	{
		return number;
	}
	
	/**
	 * @param 对number进行赋值
	 */
	public void setNumber(double number)
	{
		this.number = number;
	}
	
	/**
	 * @return 返回 unit
	 */
	public String getUnit()
	{
		return unit;
	}
	
	/**
	 * @param 对unit进行赋值
	 */
	public void setUnit(String unit)
	{
		this.unit = unit;
	}
	
	/**
	 * @return 返回 price
	 */
	public double getPrice()
	{
		return price;
	}
	
	/**
	 * @param 对price进行赋值
	 */
	public void setPrice(double price)
	{
		this.price = price;
	}
	
	/**
	 * @return 返回 supplier
	 */
	public String getSupplier()
	{
		return supplier;
	}
	
	/**
	 * @param 对supplier进行赋值
	 */
	public void setSupplier(String supplier)
	{
		this.supplier = supplier;
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
	public void setCreateTime(Date createtime)
	{
		this.createTime = createtime;
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

	public String getMaterial()
    {
    	return material;
    }

	public void setMaterial(String material)
    {
    	this.material = material;
    }

	public String getModel()
    {
    	return model;
    }

	public void setModel(String model)
    {
    	this.model = model;
    }

	public String getSpec()
    {
    	return spec;
    }

	public void setSpec(String spec)
    {
    	this.spec = spec;
    }
	
}