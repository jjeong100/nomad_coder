package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MatRequireVO;
import org.rnt.com.vo.RtnVO;

public interface MatRequireService {
	public RtnVO insert(MatRequireVO param);
	public RtnVO select(MatRequireVO param);
	public RtnVO update(MatRequireVO param);
	public RtnVO delete(MatRequireVO param);
	public RtnVO searchList(MatRequireVO param);
	public RtnVO searchListTotCnt(MatRequireVO param);
	public RtnVO searchRequireMatList(MatRequireVO param);
	public RtnVO searchMatRequireList(MatRequireVO param);
	public RtnVO searchRequireMatListByChildProdSeq(MatRequireVO param);
}
