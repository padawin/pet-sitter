#!/usr/local/bin/python3
from skimage.measure import compare_ssim as ssim
import numpy as np
import cv2
import sys

# kindly learnt from
# http://www.pyimagesearch.com/2014/09/15/python-compare-two-images/
def mse(imageA, imageB):
	# the 'Mean Squared Error' between the two images is the
	# sum of the squared difference between the two images;
	# NOTE: the two images must have the same dimension
	err = np.sum((imageA.astype("float") - imageB.astype("float")) ** 2)
	err /= float(imageA.shape[0] * imageA.shape[1])

	# return the MSE, the lower the error, the more "similar" the two images are
	return err


if __name__ == "__main__":
	# load the images -- the original, the original + contrast,
	# and the original + photoshop
	print("previous: {}".format(sys.argv[1]))
	print("current: {}".format(sys.argv[2]))
	prev = cv2.imread(sys.argv[1], 0)
	curr = cv2.imread(sys.argv[2], 0)

	# compare the images
	resultMse = mse(prev, curr)
	resultSsim = ssim(prev, curr)

	print(resultMse, resultSsim)
	if resultSsim < 0.550000 or resultMse > 200:
		exit(1)
	else:
		exit(0)
