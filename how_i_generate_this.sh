sudo apt install ruby-full build-essential zlib1g-dev
sudo gem install jekyll bundler

sudo bundle
sudo apt install npm
npm install & npm run build

jekyll serve

# https://jjikin.com/posts/Jekyll-Chirpy-%ED%85%8C%EB%A7%88%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-Github-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%A7%8C%EB%93%A4%EA%B8%B0(2023-6%EC%9B%94-%EA%B8%B0%EC%A4%80)/

# installing nodejs 20.x at here, https://github.com/nodesource/distributions


## 세부 세팅 https://www.irgroup.org/posts/jekyll-chirpy/

# WSL2에서 설치했을 때, 만약 호스트 pc 에서 안보인다면? 챗지피티한테 물어본 결과 다음과 같다

# WSL2 안에서 ip addr show eth0 쳐서 inet 주소값 확인 (외부 접근 주소 확인)
# jekyll serve --host 0.0.0.0 으로 바꿔서 외부에서도 접근 가능하도록 수정
# 호스트pc 웹브라우저에서 inet 주소값:4000으로 접근

# 보통은 VSCode에서 자동으로 port forwarding을 통해 잡아주지만, 간혹 이상하게 웹 페이지가 연결은 되는데 뜨진 않을 때가 있다.
# 호스트pc에서 실행->resmon(리소스모니터)->수신대기포트 탭에서 혹시 jekyll 서버의 포트를 이미 사용하는 다른 프로세스가 있는지 확인한다. 

# port 변경 방법은 그냥 _config.yaml에서 post : 3999 항목을 추가하면 끝이다.