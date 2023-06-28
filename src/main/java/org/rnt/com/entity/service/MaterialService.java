package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.vo.RtnVO;

public interface MaterialService {
	public RtnVO insert(MaterialVO param);
	public RtnVO select(MaterialVO param);
	public RtnVO update(MaterialVO param);
	public RtnVO delete(MaterialVO param);
	public RtnVO searchList(MaterialVO param);
	public RtnVO searchListTotCnt(MaterialVO param);
	public RtnVO searchPopBomMatList(MaterialVO param);
}
