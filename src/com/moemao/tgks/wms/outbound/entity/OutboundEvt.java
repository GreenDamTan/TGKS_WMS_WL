package com.moemao.tgks.wms.outbound.entity;

import java.util.Date;

public class OutboundEvt
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
	 * 是否已打印（0 未打印；1 已打印）
	 */
	private String print;
	
	/**
	 * 出库数量
	 */
	private double number;
	
	/**
	 * 库存单位
	 */
	private String unit;
	
	/**
	 * 出库单价
	 */
	private double price;
	
	/**
	 * 税点
	 */
	private double tax;
	
	/**
	 * 总价
	 */
	private double total;
	
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
	 * 客户
	 */
	private String custom;
	
	/**
	 * 出库时间
	 */
	private Date createTime;
	
	/**
	 * 关联库存ID
	 */
	private String commodityId;
	
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
	 * @return 返回 print
	 */
	public String getPrint()
	{
		return print;
	}
	
	/**
	 * @param 对print进行赋值
	 */
	public void setPrint(String print)
	{
		this.print = print;
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
	
	public double getTax()
    {
    	return tax;
    }

	public void setTax(double tax)
    {
    	this.tax = tax;
    }

	public double getTotal()
    {
    	return total;
    }

	public void setTotal(double total)
    {
    	this.total = total;
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

	public String getCommodityId()
    {
    	return commodityId;
    }

	public void setCommodityId(String commodityId)
    {
    	this.commodityId = commodityId;
    }

	public String getRemark()
    {
    	return remark;
    }

	public void setRemark(String remark)
    {
    	this.remark = remark;
    }
	
}