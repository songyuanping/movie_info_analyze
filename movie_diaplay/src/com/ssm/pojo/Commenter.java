package com.ssm.pojo;

import java.sql.Date;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/4/24 0024
 * @version: 1.0
 */
public class Commenter {
    private String commenterID;
    private String commenterName;
    private String liveCity;
    private Date joinDate;
    private Integer friendCount;
    private Integer followerCount;
    @Override
    public String toString() {
        return "\nCommenter:[commenterID=" + commenterID + "commenterName=" + commenterName + "liveCity=" + liveCity +
                "joinDate=" + joinDate + "friendCount=" + friendCount + "followerCount=" + followerCount + "]\n";
    }
    public String getCommenterID() {
        return commenterID;
    }

    public void setCommenterID(String commenterID) {
        this.commenterID = commenterID;
    }

    public String getCommenterName() {
        return commenterName;
    }

    public void setCommenterName(String commenterName) {
        this.commenterName = commenterName;
    }

    public String getLiveCity() {
        return liveCity;
    }

    public void setLiveCity(String liveCity) {
        this.liveCity = liveCity;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public Integer getFriendCount() {
        return friendCount;
    }

    public void setFriendCount(Integer friendCount) {
        this.friendCount = friendCount;
    }

    public Integer getFollowerCount() {
        return followerCount;
    }

    public void setFollowerCount(Integer followerCount) {
        this.followerCount = followerCount;
    }
}
