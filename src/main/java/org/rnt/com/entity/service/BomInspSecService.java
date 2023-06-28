package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.BomInspSecVO;
import org.rnt.com.vo.RtnVO;

public interface BomInspSecService {
	public RtnVO insert(BomInspSecVO param);
	public RtnVO select(BomInspSecVO param);
	public RtnVO update(BomInspSecVO param);
	public RtnVO delete(BomInspSecVO param);
	public RtnVO searchList(BomInspSecVO param);
}
