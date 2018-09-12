package com.hnnd.util;

import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

public class UploadedFile {
	MultipartFile doc;

	public MultipartFile getDoc() {
		return doc;
	}

	public void setDoc(MultipartFile doc) {
		this.doc = doc;
	}
}