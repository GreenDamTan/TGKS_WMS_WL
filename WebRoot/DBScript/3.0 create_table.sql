--
-- 表的结构 `t_tgks_common_admin`
--
DROP TABLE IF EXISTS `t_tgks_common_admin`;
CREATE TABLE IF NOT EXISTS `t_tgks_common_admin` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `uid` varchar(30) NOT NULL COMMENT '用户ID',
  `level` varchar(2) NOT NULL,
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员信息表';

--
-- 表的结构 `t_tgks_common_user`
--
DROP TABLE IF EXISTS `t_tgks_common_user`;
CREATE TABLE IF NOT EXISTS `t_tgks_common_user` (
  `id` varchar(30) NOT NULL COMMENT '用户表唯一主键',
  `username` varchar(30) NOT NULL COMMENT '用户账号',
  `password` varchar(30) NOT NULL COMMENT '用户密码',
  `status` varchar(2) NOT NULL COMMENT '账号状态（0 未启动；1 启用）',
  `type` varchar(2) NOT NULL COMMENT '账号类型',
  `email` varchar(50) default NULL COMMENT '邮箱',
  `name` varchar(40) default NULL COMMENT '姓名',
  `sex` varchar(2) default NULL COMMENT '性别',
  `groupid` varchar(300) default NULL COMMENT '用户组ID',
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='公共用户信息表';



--
-- 表的结构 `t_tgks_common_usermenu`
--
DROP TABLE IF EXISTS `t_tgks_common_usermenu`;
CREATE TABLE IF NOT EXISTS `t_tgks_common_usermenu` (
  `userid` varchar(30) NOT NULL COMMENT '账号ID',
  `menuid` varchar(1000) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY  (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户菜单配置表';



--
-- 表的结构 `t_tgks_common_menu`
--
DROP TABLE IF EXISTS `t_tgks_common_menu`;
CREATE TABLE IF NOT EXISTS `t_tgks_common_menu` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `preid` varchar(30) NOT NULL COMMENT '上级菜单ID',
  `name` varchar(50) NOT NULL COMMENT '菜单名',
  `status` varchar(2) NOT NULL COMMENT '状态（0 未启动；1 启用）',
  `url` varchar(200) NOT NULL COMMENT '菜单链接',
  `level` varchar(2) NOT NULL COMMENT '菜单级别',
  `sort` varchar(5) NOT NULL COMMENT '展示顺序',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统菜单表';


--
-- 表的结构 `t_tgks_common_systemconfig`
--
DROP TABLE IF EXISTS `t_tgks_common_systemconfig`;
CREATE TABLE IF NOT EXISTS `t_tgks_common_systemconfig` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `tag` varchar(50) NOT NULL COMMENT '参数标签',
  `name` varchar(100) NOT NULL COMMENT '参数名',
  `value` varchar(256) NOT NULL COMMENT '参数值',
  `type` varchar(2) NOT NULL COMMENT '参数类型（1:简短|2:下拉|3:文本|4:单选|5:多选|6:图片）',
  `module` varchar(30) NOT NULL COMMENT '所属模块',
  `sort` varchar(5) NOT NULL COMMENT '展示顺序',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统参数表';

--
-- 表的结构 `t_tgks_common_module`
--
DROP TABLE IF EXISTS `t_tgks_common_module`;
CREATE TABLE IF NOT EXISTS `t_tgks_common_module` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `name` varchar(50) NOT NULL COMMENT '模块名称',
  `sort` varchar(5) NOT NULL COMMENT '展示顺序',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='模块信息表';



--
-- 表的结构 `t_tgks_wms_commodity`
--
DROP TABLE IF EXISTS `t_tgks_wms_commodity`;
CREATE TABLE IF NOT EXISTS `t_tgks_wms_commodity` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `code` varchar(30) default NULL COMMENT '库存编号',
  `name` varchar(200) NOT NULL COMMENT '库存名称',
  `type` varchar(3) NOT NULL COMMENT '库存分类（0 原材料；1 半成品；2 成品）',
  `status` varchar(3) NOT NULL COMMENT '状态（0 草稿；1 正式入库）',
  `number` double NOT NULL default '0' COMMENT '库存数量',
  `unit` varchar(30) default NULL COMMENT '库存单位',
  `price` double NOT NULL default '0' COMMENT '库存单价',
  `material` varchar(100) default NULL COMMENT '材质',
  `model` varchar(100) default NULL COMMENT '型号',
  `spec` varchar(100) default NULL COMMENT '规格',
  `supplier` varchar(100) default NULL COMMENT '供货商',
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
  `remark` varchar(500) default NULL COMMENT '备注'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='库存信息表';



--
-- 表的结构 `t_tgks_wms_storage`
--
DROP TABLE IF EXISTS `t_tgks_wms_storage`;
CREATE TABLE IF NOT EXISTS `t_tgks_wms_storage` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `code` varchar(30) default NULL COMMENT '库存编号',
  `name` varchar(200) NOT NULL COMMENT '库存名称',
  `type` varchar(3) NOT NULL COMMENT '库存分类（0 原材料；1 半成品；2 成品）',
  `print` varchar(3) NOT NULL COMMENT '是否已打印（0 未打印；1 已打印）',
  `number` double NOT NULL default '0' NULL COMMENT '入库数量',
  `unit` varchar(30) default NULL COMMENT '库存单位',
  `price` double NOT NULL default '0' COMMENT '入库单价',
  `material` varchar(100) default NULL COMMENT '材质',
  `model` varchar(100) default NULL COMMENT '型号',
  `spec` varchar(100) default NULL COMMENT '规格',
  `supplier` varchar(100) default NULL COMMENT '供货商',
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '入库时间',
  `commodityid` varchar(30) NOT NULL COMMENT '关联商品ID',
  `remark` varchar(500) default NULL COMMENT '备注'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='入库记录表';



--
-- 表的结构 `t_tgks_wms_outbound`
--
DROP TABLE IF EXISTS `t_tgks_wms_outbound`;
CREATE TABLE IF NOT EXISTS `t_tgks_wms_outbound` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `code` varchar(30) default NULL COMMENT '库存编号',
  `name` varchar(200) NOT NULL COMMENT '库存名称',
  `type` varchar(3) NOT NULL COMMENT '库存分类（0 原材料；1 半成品；2 成品）',
  `print` varchar(3) NOT NULL COMMENT '是否已打印（0 未打印；1 已打印）',
  `number` double NOT NULL default '0' COMMENT '出库数量',
  `unit` varchar(30) default NULL COMMENT '库存单位',
  `price` double NOT NULL default '0' COMMENT '出库单价',
  `tax` double NOT NULL default '0' COMMENT '税点',
  `total` double NOT NULL default '0' COMMENT '总价',
  `material` varchar(100) default NULL COMMENT '材质',
  `model` varchar(100) default NULL COMMENT '型号',
  `spec` varchar(100) default NULL COMMENT '规格',
  `custom` varchar(100) default NULL COMMENT '客户',
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '出库时间',
  `commodityid` varchar(30) NOT NULL COMMENT '关联商品ID',
  `remark` varchar(500) default NULL COMMENT '备注'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='出库记录表';



--
-- 表的结构 `t_tgks_wms_outboundorder`
--
DROP TABLE IF EXISTS `t_tgks_wms_outboundorder`;
CREATE TABLE IF NOT EXISTS `t_tgks_wms_outboundorder` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `outboundid` varchar(2000) NOT NULL default '' COMMENT '出库记录ID',
  `custom` varchar(100) NOT NULL default '' COMMENT '客户',
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='出货单信息表';



--
-- 表的结构 `t_tgks_wms_supplier`
--
DROP TABLE IF EXISTS `t_tgks_wms_supplier`;
CREATE TABLE IF NOT EXISTS `t_tgks_wms_supplier` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `name` varchar(100) NOT NULL COMMENT '供货商名称',
  `address` varchar(200) default NULL COMMENT '地址',
  `account` varchar(100) default NULL COMMENT '银行账户',
  `bank` varchar(200) default NULL COMMENT '开户银行',
  `taxnumber` varchar(50) default NULL COMMENT '税号',
  `details` varchar(1000) default NULL COMMENT '详细信息',
  `category` varchar(500) default NULL COMMENT '主营商品类别',
  `url` varchar(100) default NULL COMMENT '网址URL',
  `person` varchar(50) default NULL COMMENT '联系人',
  `sex` varchar(5) default NULL COMMENT '性别',
  `age` varchar(5) default NULL COMMENT '年龄',
  `email` varchar(50) default NULL COMMENT '邮箱',
  `mobile` varchar(30) default NULL COMMENT '手机',
  `tel` varchar(30) default NULL COMMENT '电话',
  `fax` varchar(30) default NULL COMMENT '传真',
  `qq` varchar(30) default NULL COMMENT 'QQ',
  `alww` varchar(30) default NULL COMMENT '阿里旺旺',
  `msn` varchar(30) default NULL COMMENT 'MSN',
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
  `remark` varchar(500) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='供货商信息表';



--
-- 表的结构 `t_tgks_wms_custom`
--
DROP TABLE IF EXISTS `t_tgks_wms_custom`;
CREATE TABLE IF NOT EXISTS `t_tgks_wms_custom` (
  `id` varchar(30) NOT NULL COMMENT '表唯一主键',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `address` varchar(200) default NULL COMMENT '地址',
  `tel` varchar(30) default NULL COMMENT '电话',
  `fax` varchar(30) default NULL COMMENT '传真',
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
  `remark` varchar(500) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='客户信息表';