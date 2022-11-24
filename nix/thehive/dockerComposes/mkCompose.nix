{version ? "latest"}: let
  networks = {
    default.driver = "bridge";
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

  env.connector-history =
    {
      CONNECTOR_ID = "\${CONNECTOR_HISTORY_ID}"; # Valid UUIDv4
      CONNECTOR_TYPE = "STREAM";
      CONNECTOR_NAME = "History";
      CONNECTOR_SCOPE = "history";
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-common = {
    CONNECTOR_CONFIDENCE_LEVEL = 15; # From 0 (Unknown) to 100 (Fully trusted)
    CONNECTOR_LOG_LEVEL = "info";
  };

  env.connector-export-file-stix =
    {
      CONNECTOR_ID = "\${CONNECTOR_EXPORT_FILE_STIX_ID}";
      CONNECTOR_TYPE = "INTERNAL_EXPORT_FILE";
      CONNECTOR_NAME = "ExportFileCsv";
      CONNECTOR_SCOPE = "text/csv";
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-export-file-csv =
    {
      CONNECTOR_ID = "\${CONNECTOR_EXPORT_FILE_CSV_ID}";
      CONNECTOR_TYPE = "INTERNAL_EXPORT_FILE";
      CONNECTOR_NAME = "ExportFileCsv";
      CONNECTOR_SCOPE = "text/plain";
    }
    // env.opencti-common
    // env.connector-common;

  env.connector-export-file-txt =
    {
      CONNECTOR_ID = "\${CONNECTOR_EXPORT_FILE_TXT_ID}";
      CONNECTOR_TYPE = "INTERNAL_EXPORT_FILE";
      CONNECTOR_NAME = "ExportFileTxt";
      CONNECTOR_SCOPE = "text/plain";
    }
    // env.opencti-common
    // env.connector-common;
in {
  version = "3";

  services.thehive = {
    image = "strangebee/thehive:latest";
    restart = "unless-stopped";
    volumes = ["redisdata:/data"];
    depends_on = ["cassandra" "elasticsearch" "cortex"];
    mem_limit = "1500m";
    ports = ["0.0.0.0:9000:9000"];
  };

  services.cassandra = {
    image = "cassandra:4";
    restart = "unless-stopped";
    volumes = ["cassandradata:/var/lib/cassandra"];
    ports = ["0.0.0.0:9042:9042"];
    environment = env.cassandra;
  };

  services.minio = {
    image = "minio/minio:RELEASE.2022-02-26T02-54-46Z";
    restart = "always";
    volumes = ["s3data:/data"];
    ports = ["9000:9000"];
    environment = env.minio;
    command = "server /data";
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
    volumes = ["esdata:/usr/share/elasticsearch/data"];
    environment = [
      "discovery.type=single-node"
      "xpack.ml.enabled=false"
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
    networks = "default";
  };

  services.cortex = {
    image = "thehiveproject/cortex:${version}";
    restart = "unless-stopped";
    environment = {
      job_directory = "/opt/cortex/jobs";
    };
    depends_on = ["elasticsearch"];
  };

  volumes = {
    esdata = {};
    s3data = {};
    redisdata = {};
    amqpdata = {};
  };
}
