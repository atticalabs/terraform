{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 3,
      "width": 12,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
          [
            "AWS/ApplicationELB",
            "HTTPCode_Target_2XX_Count",
            "LoadBalancer",
            "${alb_name}",
            {
              "stat": "Sum",
              "period": 60,
              "color": "#2ca02c",
              "label": "2XX"
            }
          ],
          [
            ".",
            "HTTPCode_Target_4XX_Count",
            ".",
            ".",
            {
              "stat": "Sum",
              "period": 60,
              "yAxis": "left",
              "label": "4XX",
              "color": "#1c601c"
            }
          ],
          [
            ".",
            "HTTPCode_ELB_5XX_Count",
            ".",
            ".",
            {
              "stat": "Sum",
              "period": 60,
              "yAxis": "right",
              "color": "#d62728",
              "label": "ELB_5XX"
            }
          ],
          [
            ".",
            "HTTPCode_Target_5XX_Count",
            ".",
            ".",
            {
              "stat": "Sum",
              "period": 60,
              "yAxis": "right",
              "label": "5XX"
            }
          ]
        ],
        "region": "${region}",
        "period": 300,
        "title": "Requests per minute"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 3,
      "height": 3,
      "properties": {
        "view": "singleValue",
        "metrics": [
          [
            "AWS/ApplicationELB",
            "RequestCount",
            "LoadBalancer",
            "${alb_name}",
            {
              "stat": "Sum",
              "period": 60
            }
          ]
        ],
        "region": "${region}",
        "period": 300,
        "title": "RPM"
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ClusterName",
            "${cluster_name}",
            {
              "stat": "Maximum"
            }
          ],
          [
            ".",
            "MemoryReservation",
            ".",
            ".",
            {
              "stat": "Maximum"
            }
          ],
          [
            ".",
            "CPUUtilization",
            ".",
            ".",
            {
              "yAxis": "right",
              "stat": "Maximum"
            }
          ],
          [
            ".",
            "CPUReservation",
            ".",
            ".",
            {
              "yAxis": "right",
              "stat": "Maximum"
            }
          ]
        ],
        "region": "${region}",
        "title": "ECS MEM/CPU"
      }
    },
    {
      "type": "metric",
      "x": 6,
      "y": 0,
      "width": 3,
      "height": 3,
      "properties": {
        "view": "singleValue",
        "metrics": [
          [
            "AWS/ApplicationELB",
            "NewConnectionCount",
            "LoadBalancer",
            "${alb_name}"
          ]
        ],
        "region": "${region}",
        "title": "New Connections"
      }
    },
    {
      "type": "metric",
      "x": 9,
      "y": 0,
      "width": 3,
      "height": 3,
      "properties": {
        "view": "singleValue",
        "metrics": [
          [
            "AWS/ApplicationELB",
            "ActiveConnectionCount",
            "LoadBalancer",
            "${alb_name}"
          ]
        ],
        "region": "${region}",
        "title": "Active Connections"
      }
    }   
  ]
}
