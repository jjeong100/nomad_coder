package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.WorkEquipmentVO;
import org.rnt.com.vo.RtnVO;

public interface WorkEquipmentService {
	public RtnVO insert(WorkEquipmentVO param);
	public RtnVO select(WorkEquipmentVO param);
	public RtnVO searchList(WorkEquipmentVO param);
	public RtnVO update(WorkEquipmentVO param);
	public RtnVO delete(WorkEquipmentVO param);
}
