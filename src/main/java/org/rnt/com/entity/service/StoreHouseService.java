package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.vo.RtnVO;

public interface StoreHouseService {
	public RtnVO insert(StoreHouseVO param);
	public RtnVO select(StoreHouseVO param);
	public RtnVO update(StoreHouseVO param);
	public RtnVO delete(StoreHouseVO param);
	public RtnVO searchList(StoreHouseVO param);
	public RtnVO searchListTotCnt(StoreHouseVO param);
}
