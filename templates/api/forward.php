<?php

/**
 * Runs a furnace command
 * @param string $command
 * @return array|mixed
 */
function run($command = '', $parameters = ''){
    $query = 'sudo /usr/local/bin/furnace ' . $command . ' ' . $parameters;

    $output = [];
    exec($query, $output);
    return count($output) === 1 ? $output[0] : $output;
}

/**
 * Parses arguments from array to bash-syntax
 * @param $arguments
 * @return string
 */
function parse_args($arguments){
    $parsed = '';
    foreach ($arguments as $key => $value) {
        $parsed .= '--' . $key . ' "' . $value . '" ';
    }
    return $parsed;
}

// Base settings
$app_token = run('api token');

// Passed data
$token = $_GET['token'];
unset($_GET['token']);
$command = $_GET['cmd'];
unset($_GET['cmd']);

if($token !== $app_token){
    die('Invalid token');
}

header('Content-type: application/json');
echo json_encode(run($command, parse_args($_GET)));
