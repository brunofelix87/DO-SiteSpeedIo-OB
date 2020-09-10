module.exports = async function (context, commands) {
    await commands.navigate(
        'https://<BEEHIVE>.omnibees.test/'
    );
    try {
        // Add text into an input field y finding the field by id
        await commands.addText.byId('', 'username');
        await commands.addText.byId('', 'password');

        // find the sumbit button and click it
        await commands.click.byIdAndWait('btn-start-session');

        // we wait for something on the page that verifies that we are logged in
        return commands.wait.byId('appRoot', 3000);

    } catch (e) {
        throw e;
    }
};