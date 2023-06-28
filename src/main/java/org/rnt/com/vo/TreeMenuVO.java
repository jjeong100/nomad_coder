package org.rnt.com.vo;

import java.io.Serializable;
import java.util.List;

public class TreeMenuVO implements Serializable {
    private static final long serialVersionUID = 3052771954515811258L;
    private String id;
    private String text;
    private String itemCd;
    private TreeStateVO state;
    private List<?> children;
    
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
    public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	public TreeStateVO getState() {
        return state;
    }
    public void setState(TreeStateVO state) {
        this.state = state;
    }
    public List<?> getChildren() {
        return children;
    }
    public void setChildren(List<?> children) {
        this.children = children;
    }
    
}