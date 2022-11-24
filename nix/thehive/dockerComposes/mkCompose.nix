{version ? "latest"}: let
  networks = {
    thehive.driver = "bridge";
  };

  env.minio = {
    MINIO__ENDPOINT = "minio";
    MINIO__PORT = "9000";
    MINIO__USE_SSL = "false";
    MINIO__ACCESS_KEY = "\${MINIO_ROOT_USER}";
    MINIO__SECRET_KEY = "\${MINIO_ROOT_PASSWORD}";
  };

  env.cassandra = {
    CASSANDRA_CLUSTER_NAME = "TheHive";
  };
in {
  version = "3";
  inherit networks;

  services.thehive = {
    image = "strangebee/thehive:latest";
    restart = "unless-stopped";
    volumes = ["thehivedata:/etc/thehive/application.conf"];
    enviroment = {
      JVM_OPT = "-Xms1024M -Xmx1024M";
    };
    ports = ["0.0.0.0:9000:9000"];
    command = [
      "--secret"
      "lab123456789"
      "--cql-hostnames"
      "cassandra"
      "--index-backend"
      "elasticsearch"
      "--es-hostnames"
      "elasticsearch"
      "--s3-endpoint"
      "http://minio:9002"
      "--s3-access-key"
      "minioadmin"
      "--s3-secret-key"
      "minioadmin"
      "--s3-use-path-access-style"
      "--no-config-cortex"
    ];
    depends_on = ["cassandra" "elasticsearch" "cortex"];
    mem_limit = "1500m";
  };

  services.cassandra = {
    image = "cassandra:4";
    restart = "unless-stopped";
    volumes = ["cassandradata:/var/lib/cassandra"];
    ports = ["0.0.0.0:9042:9042"];
    environment = env.cassandra;
  };

  services.minio = {
    image = "quay.io/minio/minio";
    restart = "unless-stopped";
    volumes = ["miniodata:/data"];
    ports = ["9000:9000"];
    environment = env.minio;
    command = ["minio" "server" "/data" "--console-address" ":9002"];
    healthcheck = {
      test = ["CMD" "curl" "-f" "http://localhost:9000/minio/health/live"];
      interval = "30s";
      timeout = "20s";
      retries = 3;
    };
  };

  services.elasticsearch = {
    image = "docker.elastic.co/elasticsearch/elasticsearch:7.17.4";
    restart = "unless-stopped";
    volumes = ["elasticsearchdata:/usr/share/elasticsearch/data"];
    environment = [
      "discovery.type=single-node"
      "xpack.ml.enabled=false"
      "http.host=0.0.0.0"
      "ES_JAVA_OPTS=-Xms256m -Xmx256m"
    ];
    ulimits = {
      memlock = {
        soft = "-1";
        hard = "-1";
      };
      nofile = {
        soft = 65536;
        hard = 65536;
      };
    };
    networks = "thehive";
  };

  services.cortex = {
    image = "thehiveproject/cortex:${version}";
    restart = "unless-stopped";
    ports = ["0.0.0.0:9001:9001"];
    environment = {
      job_directory = "/opt/cortex/jobs";
    };
    volume = [
      "cortexdata:/var/run/docker.sock"
      "cortexdata:/opt/cortex/jobs"
      "cortexdata:/var/log/cortex"
      "cortexdata:/cortex/application.conf"
    ];
    depends_on = ["elasticsearch"];
    networks = "thevhie";
  };

  volumes = {
    miniodata = {};
    cassandradata = {};
    elasticsearchdata = {};
    cortexdata = {};
    thehivedata = {};
  };
}
