package org.rnt.com.vo;

import java.io.Serializable;

public class TreeStateVO implements Serializable {
    private static final long serialVersionUID = 1052711954515811258L;

    private boolean opened = true;
    private boolean selected = false;
    public boolean isOpened() {
        return opened;
    }
    public void setOpened(boolean opened) {
        this.opened = opened;
    }
    public boolean isSelected() {
        return selected;
    }
    public void setSelected(boolean selected) {
        this.selected = selected;
    }
    

}