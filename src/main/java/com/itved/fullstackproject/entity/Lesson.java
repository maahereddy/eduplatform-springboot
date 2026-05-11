package com.itved.fullstackproject.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Lesson {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String videoUrl;

    private boolean isPreview; // 👈 FREE or PAID

    private Long courseId;
    private String imageUrl;
    
    private Integer position;

    public int getPosition() {
        return position;
    }

  

    public void setPosition(Integer position) {
		this.position = position;
	}



	public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getVideoUrl() {
		return videoUrl;
	}

	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}

	public boolean isPreview() {
		return isPreview;
	}

	public void setPreview(boolean isPreview) {
		this.isPreview = isPreview;
	}

	public Long getCourseId() {
		return courseId;
	}

	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}

	@Override
	public String toString() {
		return "Lesson [id=" + id + ", title=" + title + ", videoUrl=" + videoUrl + ", isPreview=" + isPreview
				+ ", courseId=" + courseId + ", imageUrl=" + imageUrl + "]";
	}


    // getters & setters
    
}
