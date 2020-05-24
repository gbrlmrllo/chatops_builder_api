# lib/tasks/kube.rake

# Turn off Rake noise
Rake.application.options.trace = false

Dotenv.load('.env.production.cluster')

namespace :kube do
  desc 'Print useful information aout our Kubernete setup'
  task :list do
    kubectl 'get all --all-namespaces'
  end

  desc 'Apply our Kubernete configurations to our cluster'
  task :setup do
    # Store our Docker Hub credentials in the cluster so that we can pull our Docker image
    sh %Q(
      kubectl create secret docker-registry regcred \
        --docker-server=#{ENV['DOCKER_REGISTRY_SERVER']} \
        --docker-username=#{ENV['DOCKER_USERNAME']} \
        --docker-password=#{ENV['DOCKER_PASSWORD']} \
        --docker-email=#{ENV['DOCKER_EMAIL']} \
        || true # <-- prevent error hear from exiting our rake task
    )
    # Apply our Service component
    apply "kube/service.yml"

    # Apply our Deployment component
    apply "kube/deployment.yml"
  end

  def kubectl(command)
    puts `kubectl #{command}`
  end

  def apply(configuration)
    if File.file?(configuration)
      puts %x{envsubst < #{configuration} | kubectl apply -f -}
    else
      kubectl "apply -f #{configuration}"
    end
  end
end