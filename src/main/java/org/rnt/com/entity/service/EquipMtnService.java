package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.EquipMtnVO;
import org.rnt.com.vo.RtnVO;

public interface EquipMtnService {
	public RtnVO insert(EquipMtnVO param);
	public RtnVO select(EquipMtnVO param);
	public RtnVO update(EquipMtnVO param);
	public RtnVO delete(EquipMtnVO param);
	public RtnVO searchList(EquipMtnVO param);
	public RtnVO searchListTotCnt(EquipMtnVO param);
}
