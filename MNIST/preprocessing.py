#! -*- encoding:utf-8 -*-
import sys
import Image
reload(sys)
sys.setdefaultencoding('utf-8')

im = Image.open("VMware_vCloud.jpg")
im.rotate(45).show()

# for infile in [,]:
#     outfile = "test" + ".thumbnail"
#     if infile != outfile:
#         try:
#             im = Image.open(infile)
#             im.thumbnail(size, Image.ANTIALIAS)
#             im.save(outfile, "JPEG")
#         except IOError, e:
#             print e
#             print "cannot create thumbnail for '%s'" % infile