package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.DocumentVO;
import org.rnt.com.vo.RtnVO;

public interface DocumentService {
	public RtnVO insert(DocumentVO param);
	public RtnVO select(DocumentVO param);
	public RtnVO update(DocumentVO param);
	public RtnVO delete(DocumentVO param);
	public RtnVO searchList(DocumentVO param);
	public RtnVO searchListTotCnt(DocumentVO param);
}
