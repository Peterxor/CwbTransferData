<?php
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        http_response_code(404);
    }
    $config = require_once(__DIR__ . '/config.php');
    $mssql_ip = $config['mssql_ip'];
    $mssql_port = $config['mssql_port'];
    $mssql_user = $config['mssql_user'];
    $mssql_password = $config['mssql_password'];
    $mssql_database = $config['mssql_database'];

    $st_id = $_POST['ST_ID'];
    $station_ip = isset($_POST['stationIP']) ? '"' . $_POST['stationIP'] . '"' : 'null';
    $command_line = "sqlcmd -S $mssql_ip,$mssql_port -U $mssql_user -P $mssql_password -d $mssql_database -Q 'update station set stationIP=$station_ip where ST_ID= \"$st_id\"'";
    $result = shell_exec($command_line);
    if (!isset($result)) {
        http_response_code(404);
        echo json_encode([
            'message' => 'sqlcmd dont get response',
            'pass_data' => [
                'ST_ID' => $st_id,
                'stationIP' => $station_ip
            ]
        ]);
        return;
    }
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode([
        'message' => $result,
        'pass_data' => [
            'ST_ID' => $st_id,
            'stationIP' => $station_ip
        ]
    ]);


