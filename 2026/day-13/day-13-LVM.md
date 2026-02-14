>## **Day 13 – Linux Volume Management (LVM)**
-------

##**STEP1:** 
- EC2-In stance creation.
<img src="Screenshots/0.png" width="600">








##**STEP2:**
- `lsblk` lists up all the root voulmes.
<img src="Screenshots/1.png" width="600">



##**STEP3:**
- `df -h`Shows disk space usage of all mounted file systems at root level in a human-readable format.
<img src="Screenshots/2.png" width="600">


##**STEP4:**
- Using `EBS` three storage blocks have been created `/dev/xvdf` , `/dev/xvdg` , `/dev/xvdg` of 10G,12G and 5G respectiely.
- These storage blocks are then attached to the instance.

<img src="Screenshots/3.png" width="600">

##**STEP5:**
- `lsblk ` lists up the newly created blocks ,showing that the blocks have been attached to the instance.

<img src="Screenshots/4.png" width="600">

##**STEP6:**
- Now physical Volumes (PV) would be created, `pvs` shows there are no physical volumes already created.
- Therefore `pvcreate` helps to create PVs of these storage blocks.


<img src="Screenshots/5.png" width="600">

##**STEP7:**
- `pvdisplay` displays all te details of each PV created.
<img src="Screenshots/6-1.png" width="600">

<img src="Screenshots/6-2.png" width="600">

<img src="Screenshots/6-3.png" width="600">


##**STEP8:**
- A Volume Group would be now created using any of these PVs (as per requirement).
<img src="Screenshots/7-1.png" width="600">

- `vgdisplay` ellaborates the details of the Vol Group created.

<img src="Screenshots/7-2.png" width="600">




##**STEP9**
- From Vol. Group, Logical Volumes are created of required sizes.

<img src="Screenshots/8.png" width="600">


<img src="Screenshots/8-2.png" width="600">


##**STEP10:**
- `lsblk` shows the slicing up of 10G from the Volume Group.

<img src="Screenshots/9.png" width="600">



##**STEP11:**
- `lvs` is showing up the Logical Vol. cretaed from the Vol. Group of 10 G.
 
<img src="Screenshots/10.png" width="600">


##**STEP12:**
- The most imp step is to mount up the Logical Vol. to the instance.That includes  
- [ ] Creation of mount folder 
- [ ] Formatting of the whole path.

<img src="Screenshots/11.png" width="600">



##**STEP13:**
- After the completion of the above steps, using `mount` command, the source would be mounted up to the destination.
<img src="Screenshots/12.png" width="600">


##**STEP14:**
- `df -h` shows out Logical Vol. has been mounted up succssfully.
<img src="Screenshots/13.png" width="600">


##**STEP13:**
- The screenshot ellaborates that once the mounting part is done , directories and files can be created inside that volume according to the requirement.
- These files/directories can be accessed from the root as well.
<img src="Screenshots/14.png" width="600">

>## **How To Extend the Volume**
## **Step1:**

- `lvextend` command helps to extend the current Logical Volume.
- Here the volume has been extended upto 3G two times so total increment would be 6G.

<img src="Screenshots/vol-extend1.png" width="600">

## **Step2:**

-`resize2fs` It is typically used after extending or reducing an LVM logical volume to make the filesystem use the updated space.


<img src="Screenshots/vol-extend2.png" width="600">

## **Step3:**

- `df-h ` is showing the total size of 16G.

<img src="Screenshots/vol-extend3.png" width="600">

## **Step4:**

- Since we created the Volume Group of 10G+12G= 22G total,after extending the volume, the Logical Volume is taking up more from the other PV, which is also the part of Volume Group.  
<img src="Screenshots/vol-extend4.png" width="600">
