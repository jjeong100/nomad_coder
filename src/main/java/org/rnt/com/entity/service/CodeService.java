package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.CodeVO;
import org.rnt.com.vo.RtnVO;

public interface CodeService {
    public RtnVO insert(CodeVO param);
	public RtnVO select(CodeVO param);
	public RtnVO update(CodeVO param);
	public RtnVO delete(CodeVO param);
	public RtnVO searchList(CodeVO param);
	public RtnVO searchListTotCnt(CodeVO param);
	
}
