package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.DataBackupVO;
import org.rnt.com.vo.RtnVO;

public interface DataBackupService {
	public RtnVO insert(DataBackupVO param);
	public RtnVO select(DataBackupVO param);
	public RtnVO update(DataBackupVO param);
	public RtnVO delete(DataBackupVO param);
	public RtnVO searchList(DataBackupVO param);
	public RtnVO searchListTotCnt(DataBackupVO param);
}
