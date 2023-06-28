package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.DeviceVO;
import org.rnt.com.vo.RtnVO;

public interface DeviceService {
	public RtnVO insert(DeviceVO param);
	public RtnVO select(DeviceVO param);
	public RtnVO update(DeviceVO param);
	public RtnVO delete(DeviceVO param);
	public RtnVO searchList(DeviceVO param);
	public RtnVO searchListTotCnt(DeviceVO param);
}
