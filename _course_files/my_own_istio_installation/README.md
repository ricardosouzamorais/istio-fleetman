*  Apply:<br/>
    `istioctl manifest apply -f 1-istio-init-istioctl.yml --set values.global.jwtPolicy=first-party-jwt`
*  Generate pure YAML k8s files:<br/>
    `istioctl manifest generate -f 1-istio-init-istioctl.yml --set values.global.jwtPolicy=first-party-jwt > 1-istio-init-k8s.yml `