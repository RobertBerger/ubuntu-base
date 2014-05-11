HERE=$(pwd)

echo "+  git checkout master"
git checkout master

echo "+ cd ../../ubuntu-base-top/ubuntu-base-test/"
cd ../../ubuntu-base-top/ubuntu-base-test/
echo "+  git checkout master"
git checkout master

echo "+ cd ${HERE}"

for BRANCH in master devel
do
  echo "+ ----->"
  echo "+ cd ../../ubuntu-base-top/ubuntu-base-test/"
  cd ../../ubuntu-base-top/ubuntu-base-test/
  echo "+  git checkout ${BRANCH}"
  git checkout ${BRANCH}
  echo "+ cd ${HERE}"
  cd ${HERE}
  echo "+ cd .."
  cd ..
  echo "+ git checkout ${BRANCH}"
  git checkout ${BRANCH}
  echo "+ git pull ../ubuntu-base-top/ubuntu-base-test"
  git pull ../ubuntu-base-top/ubuntu-base-test
  echo "+ git log --name-status HEAD^..HEAD"
  git log --name-status HEAD^..HEAD
  echo "+ git checkout master"
  git checkout master
  echo "+ cd ${HERE}"
  cd ${HERE}
  echo "+ press <ENTER> to go on"
  read r
  echo "+ <-----"
done

echo "+  git checkout master"
git checkout master

echo "+ cd ../../ubuntu-base-top/ubuntu-base-test/"
cd ../../ubuntu-base-top/ubuntu-base-test/
echo "+  git checkout master"
git checkout master

echo "+ cd ${HERE}"

echo "+ git status"
git status
